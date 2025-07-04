---@class NativeSortedCodeActions
---@field code_action fun(opts?: vim.lsp.buf.code_action.Opts)

local M = {
  textDocument_codeAction = 'textDocument/codeAction',
}

---@param opts? vim.lsp.buf.code_action.Opts
function M.code_action(opts)
  vim.validate('options', opts, 'table', true)
  opts = opts or {}
  -- Detect old API call code_action(context) which should now be
  -- code_action({ context = context} )
  --- @diagnostic disable-next-line:undefined-field
  if opts.diagnostics or opts.only then
    opts = { options = opts }
  end

  local context = opts.context and vim.deepcopy(opts.context) or {}
  context.triggerKind = context.triggerKind or vim.lsp.protocol.CodeActionTriggerKind.Invoked

  local mode = vim.api.nvim_get_mode().mode
  local bufnr = vim.api.nvim_get_current_buf()
  local win = vim.api.nvim_get_current_win()
  local clients = vim.lsp.get_clients({ bufnr = bufnr, method = 'textDocument/codeAction' })

  if #clients == 0 then
    if next(vim.lsp.get_clients({ bufnr = bufnr })) then
      vim.notify("Code action not supported by any active LSP server", vim.log.levels.WARN)
    end
    return
  end

  ---@type table<integer, vim.lsp.CodeActionResultEntry>
  local results = {}
  local remaining = #clients

  ---@param err? lsp.ResponseError
  ---@param result? (lsp.Command|lsp.CodeAction)[]
  ---@param ctx lsp.HandlerContext
  local function on_result(err, result, ctx)
    results[ctx.client_id] = { error = err, result = result, ctx = ctx }
    remaining = remaining - 1
    if remaining == 0 then
      M.on_code_action_results(results, opts)
    end
  end

  for _, client in ipairs(clients) do
    ---@type lsp.CodeActionParams
    local params
    if opts.range then
      local start = assert(opts.range.start, 'range must have a `start` property')
      local end_ = assert(opts.range['end'], 'range must have a `end` property')
      params = vim.lsp.util.make_given_range_params(start, end_, bufnr, client.offset_encoding)
    elseif mode == 'v' or mode == 'V' then
      local range = M.range_from_selection(bufnr, mode)
      params = vim.lsp.util.make_given_range_params(range.start, range['end'], bufnr, client.offset_encoding)
    else
      params = vim.lsp.util.make_range_params(win, client.offset_encoding)
    end

    --- @cast params lsp.CodeActionParams
    if context.diagnostics then
      params.context = context
    else
      local ns_push = vim.lsp.diagnostic.get_namespace(client.id, false)
      local ns_pull = vim.lsp.diagnostic.get_namespace(client.id, true)
      local diagnostics = {}
      local lnum = vim.api.nvim_win_get_cursor(0)[1] - 1
      vim.list_extend(diagnostics, vim.diagnostic.get(bufnr, { namespace = ns_pull, lnum = lnum }))
      vim.list_extend(diagnostics, vim.diagnostic.get(bufnr, { namespace = ns_push, lnum = lnum }))
      params.context = vim.tbl_extend('force', context, {
        ---@diagnostic disable-next-line: no-unknown
        diagnostics = vim.tbl_map(function(d)
          return d.user_data.lsp
        end, diagnostics),
      })
    end

    client:request(M.textDocument_codeAction, params, on_result, bufnr)
  end
end

function M.on_code_action_results(results, opts)
  ---@param a lsp.Command|lsp.CodeAction
  local function action_filter(a)
    if opts and opts.context and opts.context.only then
      if not a.kind then
        return false
      end
      local found = false
      for _, o in ipairs(opts.context.only) do
        if a.kind == o or vim.startswith(a.kind, o .. '.') then
          found = true
          break
        end
      end
      if not found then
        return false
      end
    end
    if opts and opts.filter and not opts.filter(a) then
      return false
    end
    return true
  end

  ---@type {action: lsp.Command|lsp.CodeAction, ctx: lsp.HandlerContext}[]
  local actions = {}
  for _, result in pairs(results) do
    for _, action in pairs(result.result or {}) do
      if action_filter(action) then
        table.insert(actions, { action = action, ctx = result.ctx })
      end
    end
  end

  -- ===== Sort actions =====
  table.sort(actions, function(a, b)
    if a.action.isPreferred then
      return true
    end

    if b.action.isPreferred then
      return false
    end

    local kind_a = a.action.kind or ""
    local kind_b = b.action.kind or ""
    if kind_a ~= kind_b then
      return kind_a < kind_b
    end

    local title_a = a.action.title or ""
    local title_b = b.action.title or ""
    return title_a:lower() < title_b:lower()
  end)

  if #actions == 0 then
    vim.notify('No code actions available', vim.log.levels.INFO)
    return
  end

  ---@param action lsp.Command|lsp.CodeAction
  ---@param client vim.lsp.Client
  ---@param ctx lsp.HandlerContext
  local function apply_action(action, client, ctx)
    if action.edit then
      vim.lsp.util.apply_workspace_edit(action.edit, client.offset_encoding)
    end
    local a_cmd = action.command
    if a_cmd then
      ---@type lsp.CodeAction|lsp.Command
      local command = type(a_cmd) == 'table' and a_cmd or action
      client:exec_cmd(command, ctx)
    end
  end

  ---@param choice {action: lsp.Command|lsp.CodeAction, ctx: lsp.HandlerContext}
  local function on_user_choice(choice)
    if not choice then
      return
    end

    local client = assert(vim.lsp.get_client_by_id(choice.ctx.client_id))
    local action = choice.action
    local bufnr = assert(choice.ctx.bufnr, 'Must have buffer number')

    if type(action.title) == 'string' and type(action.command) == 'string' then
      apply_action(action, client, choice.ctx)
      return
    end

    if not (action.edit and action.command) and client:supports_method("codeAction/resolve") then
      client:request("codeAction/resolve", action, function(err, resolved_action)
        if err then
          if action.edit or action.command then
            apply_action(action, client, choice.ctx)
          else
            vim.notify(err.code .. ': ' .. err.message, vim.log.levels.ERROR)
          end
        else
          apply_action(resolved_action, client, choice.ctx)
        end
      end, bufnr)
    else
      apply_action(action, client, choice.ctx)
    end
  end

  if opts and opts.apply and #actions == 1 then
    on_user_choice(actions[1])
    return
  end

  ---@param item {action: lsp.Command|lsp.CodeAction, ctx: lsp.HandlerContext}
  local function format_item(item)
    local clients = vim.lsp.get_clients({ bufnr = item.ctx.bufnr })
    local title = item.action.title:gsub('\r\n', '\\r\\n'):gsub('\n', '\\n')

    if #clients == 1 then
      return title
    end

    local source = vim.lsp.get_client_by_id(item.ctx.client_id).name
    return ('%s [%s]'):format(title, source)
  end

  local select_opts = {
    prompt = 'Code actions:',
    kind = 'codeaction',
    format_item = format_item,
  }
  vim.ui.select(actions, select_opts, on_user_choice)
end

function M.range_from_selection(bufnr, mode)
  local start = vim.api.nvim_buf_get_mark(bufnr, '<')
  local end_ = vim.api.nvim_buf_get_mark(bufnr, '>')
  if mode == 'V' then
    end_[2] = -1
  end
  return {
    start = { start[1] - 1, start[2] },
    ['end'] = { end_[1] - 1, end_[2] },
  }
end

return {
  code_action = M.code_action
}
