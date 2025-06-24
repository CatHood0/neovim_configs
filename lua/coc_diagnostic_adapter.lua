local namespace_id = vim.api.nvim_create_namespace("coc-diagnostics")
local M = {}

local SEVERITY_MAP = {
  error = vim.diagnostic.severity.ERROR,
  warning = vim.diagnostic.severity.WARN,
  info = vim.diagnostic.severity.INFO,
  hint = vim.diagnostic.severity.HINT,
}

--- Cache all the active buffers
local active_buffers = {}

function M.clear_buffer_diagnostics(bufnr)
  if vim.api.nvim_buf_is_valid(bufnr) then
    vim.diagnostic.reset(namespace_id, bufnr)
    active_buffers[bufnr] = nil
  end
end

function M.clear_diagnostics()
  vim.diagnostic.reset(namespace_id)
  active_buffers = {}
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
      or vim.diagnostic.severity.HINT

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
  for _, coc_diag in ipairs(coc_diags) do
    local nv_diag = coc_to_nvim_diagnostic(coc_diag)
    if nv_diag then
      table.insert(nvim_diags, nv_diag)
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
      buffer_diags[bufnr] = buffer_diags[bufnr] or {}
      local nv_diag = coc_to_nvim_diagnostic(coc_diag)
      if nv_diag then
        table.insert(buffer_diags[bufnr], nv_diag)
      end
    end
  end

  -- Update all the buffer that has diagnostics
  for bufnr, diags in pairs(buffer_diags) do
    vim.diagnostic.reset(namespace_id, bufnr)
    vim.diagnostic.set(namespace_id, bufnr, diags)
    active_buffers[bufnr] = true
  end

  -- Clean diagnostics where necessary
  for bufnr in pairs(active_buffers) do
    if not buffer_diags[bufnr] then
      M.clear_buffer_diagnostics(bufnr)
    end
  end
end

return M
