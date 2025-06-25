local namespace_id = vim.api.nvim_create_namespace("coc-diagnostics")
local M = {}

local SEVERITY_MAP = {
  error = vim.diagnostic.severity.ERROR,
  warning = vim.diagnostic.severity.WARN,
  info = vim.diagnostic.severity.INFO,
  hint = vim.diagnostic.severity.HINT,
  [1] = vim.diagnostic.severity.ERROR,
  [2] = vim.diagnostic.severity.WARN,
  [3] = vim.diagnostic.severity.INFO,
  [4] = vim.diagnostic.severity.HINT,
}

--- Cache all the active buffers
local active_buffers = {}

--- Unique diagnostic key generator
function M.get_diagnostic_key(diag)
  return string.format("%d:%d:%s:%s",
    diag.lnum or 0,
    diag.col or 0,
    diag.message:gsub("%s+", " "):sub(1, 100),
    diag.code or ""
  )
end

function M.clear_buffer_diagnostics(bufnr)
  if not vim.api.nvim_buf_is_valid(bufnr) then return end
  vim.diagnostic.reset(namespace_id, bufnr)
  active_buffers[bufnr] = nil
end

--- Transform COC ranges to valid LSP positions
local function range_to_pos(range)
  return {
    lnum = range.start.line,
    col = range.start.character,
    end_lnum = range["end"].line,
    end_col = range["end"].character,
  }
end

--- Transform COC diagnostics to Neovim LSP diagnostic format
local function coc_to_nvim_diagnostic(coc_diag)
  if type(coc_diag) ~= "table" then return nil end

  local range
  -- Checks if we need to define a range manually
  if coc_diag.location and coc_diag.location.range then
    range = coc_diag.location.range
  else
    range = {
      start = {
        line = coc_diag.lnum or 0,
        character = coc_diag.col or 0
      },
      ["end"] = {
        line = coc_diag.end_lnum or (coc_diag.lnum or 0),
        character = coc_diag.end_col or ((coc_diag.col or 0) + 1)
      }
    }
  end


  local pos = range_to_pos(range)
  local severity = type(coc_diag.severity) == "string"
      and SEVERITY_MAP[coc_diag.severity:lower()]
      or nil

  if severity == nil then
    return {}
  end

  return {
    lnum = pos.lnum,
    col = pos.col,
    end_lnum = pos.end_lnum,
    end_col = pos.end_col,
    message = coc_diag.message or "Empty diagnostic message",
    severity = severity,
    source = coc_diag.source or "COC",
    code = coc_diag.code,
    user_data = {
      coc_data = {
        file = coc_diag.file,
        level = coc_diag.level,
        location = coc_diag.location
      }
    }
  }
end

--- Update diagnostics for a particular buffer
function M.update_buffer_diagnostics(bufnr)
  if not vim.api.nvim_buf_is_valid(bufnr) then return end

  local filepath = vim.api.nvim_buf_get_name(bufnr)
  if filepath == "" then return end

  -- get all the diagnostics from this document
  local coc_diags = vim.fn.CocAction("diagnosticList", filepath) or {}
  if type(coc_diags) ~= "table" then return end


  local nvim_diags = {}
  local seen_keys = {}

  for _, coc_diag in ipairs(coc_diags) do
    local nv_diag = coc_to_nvim_diagnostic(coc_diag)
    if nv_diag and nv_diag.message ~= nil then
      local key = M.get_diagnostic_key(nv_diag)
      -- Verify if this key is already into our seen_keys table
      if not seen_keys[key] then
        seen_keys[key] = true
        table.insert(nvim_diags, nv_diag)
      end
    end
  end

  -- Clean and set new diagnostics
  vim.diagnostic.reset(namespace_id, bufnr)
  if #nvim_diags > 0 then
    vim.diagnostic.set(namespace_id, bufnr, nvim_diags)
    active_buffers[bufnr] = true
  end
end

--- Sync all the diagnostics from COC to Neovim LSP ones
function M.sync_coc_diagnostics()
  local coc_diags = vim.fn.CocAction("diagnosticList") or {}
  if type(coc_diags) ~= "table" then return end

  local buffer_diags = {}

  -- Group diagnostics per buffer
  for _, coc_diag in ipairs(coc_diags) do
    local bufnr
    if coc_diag.location and coc_diag.location.uri then
      bufnr = vim.uri_to_bufnr(coc_diag.location.uri)
    elseif coc_diag.file then
      bufnr = vim.fn.bufnr(coc_diag.file)
    end

    if bufnr and vim.api.nvim_buf_is_valid(bufnr) then
      buffer_diags[bufnr] = buffer_diags[bufnr] or { diags = {}, seen = {} }
      local nv_diag = coc_to_nvim_diagnostic(coc_diag)
      if nv_diag and nv_diag.message ~= nil then
        local key = M.get_diagnostic_key(nv_diag)
        if not buffer_diags[bufnr].seen[key] then
          buffer_diags[bufnr].seen[key] = true
          table.insert(buffer_diags[bufnr].diags, nv_diag)
        end
      end
    end
  end

  -- Update all the buffer that has diagnostics
  for bufnr, data in pairs(buffer_diags) do
    vim.diagnostic.reset(namespace_id, bufnr)
    vim.diagnostic.set(namespace_id, bufnr, data.diags)

    active_buffers[bufnr] = true
  end

  -- Clean diagnostics where necessary
  for bufnr in pairs(active_buffers) do
    if not buffer_diags[bufnr] then
      M.clear_buffer_diagnostics(bufnr)
    end
  end
end

local function handle_sync()
  vim.defer_fn(M.sync_coc_diagnostics, 300)
end

function M.setup()
  vim.diagnostic.config({
    signs = {
      text = {
        [vim.diagnostic.severity.ERROR] = " ",
        [vim.diagnostic.severity.WARN]  = " ",
        [vim.diagnostic.severity.INFO]  = " ",
        [vim.diagnostic.severity.HINT]  = "󰌵 ",
      },
      numhl = {
        [vim.diagnostic.severity.ERROR] = "DiagnosticSignError",
        [vim.diagnostic.severity.WARN]  = "DiagnosticSignWarn",
        [vim.diagnostic.severity.INFO]  = "DiagnosticSignInfo",
        [vim.diagnostic.severity.HINT]  = "DiagnosticSignHint",
      },
    },
    virtual_text = false,
    update_in_insert = true,
  })

  vim.api.nvim_create_autocmd("User", {
    pattern = "CocNvimInit",
    callback = function()
      M.sync_coc_diagnostics()
    end,
    once = true
  })

  -- On general change
  vim.api.nvim_create_autocmd("User", {
    pattern = "CocDiagnosticChange",
    callback = handle_sync
  })

  -- On update document after a code action
  -- (yeah, we need this to avoid loss diagnostics)
  vim.api.nvim_create_autocmd("User", {
    pattern = "CocAction",
    callback = function(arg)
      M.update_buffer_diagnostics(vim.api.nvim_get_current_buf())
    end
  })

  -- On save document
  vim.api.nvim_create_autocmd("BufWritePost", {
    callback = function()
      vim.defer_fn(handle_sync, 500)
    end
  })
end

return M

--[[
local M = {}

function M.setup()
  vim.diagnostic.config({
    signs = {
      enable = true,
      text = {
        [vim.diagnostic.severity.ERROR] = " ",
        [vim.diagnostic.severity.WARN]  = " ",
        [vim.diagnostic.severity.INFO]  = " ",
        [vim.diagnostic.severity.HINT]  = "󰌵 ",
      },
      texthl = {
        [vim.diagnostic.severity.ERROR] = "DiagnosticSignError",
        [vim.diagnostic.severity.WARN]  = "DiagnosticSignWarn",
        [vim.diagnostic.severity.INFO]  = "DiagnosticSignInfo",
        [vim.diagnostic.severity.HINT]  = "DiagnosticSignHint",
      },
      numhl = {
        [vim.diagnostic.severity.ERROR] = "DiagnosticSignError",
        [vim.diagnostic.severity.WARN]  = "DiagnosticSignWarn",
        [vim.diagnostic.severity.INFO]  = "DiagnosticSignInfo",
        [vim.diagnostic.severity.HINT]  = "DiagnosticSignHint",
      },
    },
    virtual_text = true,
    -- virtual_lines = {
    --  current_line = false,
    -- },
    underline = true,
    float = {
      show_header = false,
      source = 'if_many',
      border = 'rounded',
      update_in_insert = true,
      severity_sort = true,
    },
    update_in_insert = false,
    severity_sort = true, -- to allow sign columns to be showed, we use this
  })
end

return M
--]]
