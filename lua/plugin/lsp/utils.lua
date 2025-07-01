local M = {}
local group = vim.api.nvim_create_augroup('diagnostics-on-cursor-hold', {})

local function easyAutocmd(typ, pattern, cmdOrFn)
  if type(cmdOrFn) == 'function' then
    vim.api.nvim_create_autocmd(typ, { pattern = pattern, callback = cmdOrFn, group = group, once = true })
  else
    vim.api.nvim_create_autocmd(typ, { pattern = pattern, command = cmdOrFn, group = group, once = true })
  end
end

function M.create_autocmds()
  easyAutocmd({ 'CursorHold' }, nil, function()
    local opts = {
      focusable = false,
      scope = 'cursor',
      close_events = { 'BufLeave', 'CursorMoved', 'InsertEnter' },
    }
    vim.diagnostic.open_float(nil, opts)
  end)

  easyAutocmd("BufWritePre", "*.go", function()
    local params = vim.lsp.util.make_range_params(vim.api.nvim_get_current_win(), "utf-8")
    -- buf_request_sync defaults to a 1000ms timeout. Depending on your
    -- machine and codebase, you may want longer. Add an additional
    -- argument after params if you find that you have to write the file
    -- twice for changes to be saved.
    -- E.g., vim.lsp.buf_request_sync(0, "textDocument/codeAction", params, 3000)
    local result = vim.lsp.buf_request_sync(0, "textDocument/codeAction", params)
    for cid, res in pairs(result or {}) do
      for _, r in pairs(res.result or {}) do
        if r.edit then
          local enc = (vim.lsp.get_client_by_id(cid) or {}).offset_encoding or "utf-16"
          vim.lsp.util.apply_workspace_edit(r.edit, enc)
        end
      end
    end
    vim.lsp.buf.format({ async = false })
  end)
end

return M
