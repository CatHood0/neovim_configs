local M = {}

local shared_state = require('core.winbar.state')

local diagnostic_severity = {
  [vim.diagnostic.severity.ERROR] = "DiagnosticSignError",
  [vim.diagnostic.severity.WARN] = "DiagnosticSignWarn",
  [vim.diagnostic.severity.INFO] = "DiagnosticSignInfo",
  [vim.diagnostic.severity.HINT] = "DiagnosticSignHint",
}

--- Define custom hl groups
function M.define_hl_groups()
  if shared_state.state.hl_groups_defined then return end

  vim.api.nvim_set_hl(0, shared_state.config.folder_icon.hl_group, {
    fg = shared_state.config.folder_icon.color,
  })

  vim.api.nvim_set_hl(0, shared_state.config.file_icon.hl_group, {
    fg = shared_state.config.file_icon.fallback_color
  })

  shared_state.state.hl_groups_defined = true
end

--- Get all the diagnostics of the current buffer
function M.get_diagnostic()
  if not shared_state.config.show_diagnostic then
    return nil
  end
  local bufnr = vim.api.nvim_get_current_buf()

  local diagnostics = vim.diagnostic.get(bufnr)

  if not diagnostics or #diagnostics == 0 then
    return nil
  end

  local max_severity = vim.diagnostic.severity.HINT
  for _, diag in ipairs(diagnostics) do
    if diag.severity < max_severity then
      max_severity = diag.severity
    end
  end

  return diagnostic_severity[max_severity]
end

--- Get an icon using the name of the folder
function M.get_folder_icon(name)
  if shared_state.config.on_get_folder then
    local icon, color = shared_state.config.on_get_folder(name)
    return icon, color
  end

  return shared_state.config.folder_icon.icon, shared_state.config.folder_icon.hl_group
end

--- Get an icon using the name of the file and its extension
function M.get_file_icon(name)
  if shared_state.config.on_get_file then
    local ext = name:match(".+%.(.*)$") or ""
    local icon, color = shared_state.config.on_get_file(name, ext)
    return icon, color
  end

  return shared_state.config.file_icon.fallback_icon, shared_state.config.file_icon.hl_group
end

function M.setup_buffer_cleanup()
  local group = vim.api.nvim_create_augroup("WinBarBufferCleanup", { clear = true })

  -- Cuando un buffer se elimina completamente
  vim.api.nvim_create_autocmd('BufWipeout', {
    group = group,
    callback = function(args)
      local buf = args.buf
      shared_state.state.buffers[buf] = nil -- Limpiar el winbar almacenado
    end
  })
end

return M
