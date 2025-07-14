---@diagnostic disable: undefined-global
local M = {}

---@module 'core.winbar.state'
---@type State
local shared_state = require('core.winbar.state')

local diagnostic_severity = {
  [vim.diagnostic.severity.ERROR] = "DiagnosticSignError",
  [vim.diagnostic.severity.WARN] = "DiagnosticSignWarn",
  [vim.diagnostic.severity.INFO] = "DiagnosticSignInfo",
  [vim.diagnostic.severity.HINT] = "DiagnosticSignHint",
}

local support_providers = { "nvim-web-devicons", "mini-icons" }

---@param table string[]
---@param value string?
local function contains(table, value)
  for i = 1, #table do
    if (table[i] == value) then
      return true
    end
  end
  return false
end

function M.setup_provider()
  if M.check_provider() then
    if shared_state.config.icons_provider == support_providers[1] then
      shared_state.state.use_full_paths = false
      local devicons_ok, devicons = pcall(require, 'nvim-web-devicons')
      if not devicons_ok then
        vim.notify("Could not load nvim-web-devicons", vim.log.levels.WARN)
        return
      end
      devicons.setup({
        override = {
          folder = {
            icon = "",
            color = "#7ebae4",
            name = "folder"
          }
        }
      })
      shared_state.state.get_folder_icon = not devicons_ok and nil or
          function(_)
            local icon, color = devicons.get_icon("folder", "", { default = true })
            return icon, color
          end
      shared_state.state.get_file_icon = not devicons_ok and nil or
          function(name, ext)
            local icon, color = devicons.get_icon(name, ext, { default = true })
            return icon, color
          end
    end
    if shared_state.config.icons_provider == support_providers[2] then
      if MiniIcons == nil then
        vim.notify("Could not load mini-icons. Please, ensure that you call require('mini.icons').setup() before this",
          vim.log.levels.WARN)
        return
      end
      shared_state.state.use_full_paths = true
      shared_state.state.get_folder_icon =
          function(name)
            local icon, color = MiniIcons.get("directory", name)
            ---@diagnostic disable-next-line: redundant-return-value
            return icon, color
          end
      shared_state.state.get_file_icon =
          function(name, _)
            local icon, color = MiniIcons.get("extension", name)
            ---@diagnostic disable-next-line: redundant-return-value
            return icon, color
          end
    end
  end
end

---@return boolean validates if the provider passed if valid to be used
function M.check_provider()
  if not shared_state.config.icons_provider or
      not contains(support_providers, shared_state.config.icons_provider) then
    return false
  end
  return true
end

--- Define custom hl groups
function M.define_hl_groups()
  if shared_state.state.hl_groups_defined then return end

  vim.api.nvim_set_hl(0, shared_state.config.folder_icon.hl_group, {
    fg = shared_state.config.folder_icon.color,
  })

  vim.api.nvim_set_hl(0, shared_state.config.file_icon.hl_group, {
    fg = shared_state.config.file_icon.color,
  })

  vim.defer_fn(function()
    vim.api.nvim_set_hl(0, "NavicIconsFile", { fg = "#FFD700" })
    vim.api.nvim_set_hl(0, "NavicIconsModule", { fg = "#4EC9B0" })
    vim.api.nvim_set_hl(0, "NavicIconsNamespace", { fg = "#569CD6" })
    vim.api.nvim_set_hl(0, "NavicIconsPackage", { fg = "#C586C0" })
    vim.api.nvim_set_hl(0, "NavicIconsClass", { fg = "#4EC9B0" })
    vim.api.nvim_set_hl(0, "NavicIconsMethod", { fg = "#DCDCAA" })
    vim.api.nvim_set_hl(0, "NavicIconsProperty", { fg = "#9CDCFE" })
    vim.api.nvim_set_hl(0, "NavicIconsField", { fg = "#9CDCFE" })
    vim.api.nvim_set_hl(0, "NavicIconsConstructor", { fg = "#DCDCAA" })
    vim.api.nvim_set_hl(0, "NavicIconsEnum", { fg = "#4EC9B0" })
    vim.api.nvim_set_hl(0, "NavicIconsInterface", { fg = "#4EC9B0" })
    vim.api.nvim_set_hl(0, "NavicIconsFunction", { fg = "#DCDCAA" })
    vim.api.nvim_set_hl(0, "NavicIconsVariable", { fg = "#9CDCFE" })
    vim.api.nvim_set_hl(0, "NavicIconsConstant", { fg = "#4FC1FF" })
    vim.api.nvim_set_hl(0, "NavicIconsString", { fg = "#CE9178" })
    vim.api.nvim_set_hl(0, "NavicIconsNumber", { fg = "#B5CEA8" })
    vim.api.nvim_set_hl(0, "NavicIconsBoolean", { fg = "#569CD6" })
    vim.api.nvim_set_hl(0, "NavicIconsArray", { fg = "#B5CEA8" })
    vim.api.nvim_set_hl(0, "NavicIconsObject", { fg = "#4EC9B0" })
    vim.api.nvim_set_hl(0, "NavicIconsKey", { fg = "#9CDCFE" })
    vim.api.nvim_set_hl(0, "NavicIconsNull", { fg = "#569CD6" })
    vim.api.nvim_set_hl(0, "NavicIconsEnumMember", { fg = "#4EC9B0" })
    vim.api.nvim_set_hl(0, "NavicIconsStruct", { fg = "#4EC9B0" })
    vim.api.nvim_set_hl(0, "NavicIconsEvent", { fg = "#D7BA7D" })
    vim.api.nvim_set_hl(0, "NavicIconsOperator", { fg = "#D4D4D4" })
    vim.api.nvim_set_hl(0, "NavicIconsTypeParameter", { fg = "#4EC9B0" })

    vim.api.nvim_set_hl(0, "NavicText", { fg = "#cad3f5" })
    vim.api.nvim_set_hl(0, "NavicSeparator", { fg = "#808080" })
  end, 3000)

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
      ---@diagnostic disable-next-line: cast-local-type
      max_severity = diag.severity
    end
  end

  return diagnostic_severity[max_severity]
end

--- Get an icon using the name of the folder
---@param name string
---@return string, string?
function M.get_folder_icon(name)
  if shared_state.state.get_folder_icon then
    local icon, _ = shared_state.state.get_folder_icon(name)
    return icon, _
  end

  if shared_state.config.on_get_folder then
    local icon, color = shared_state.config.on_get_folder(name)
    return icon, color
  end

  return shared_state.config.folder_icon.icon, shared_state.config.folder_icon.hl_group
end

--- Get an icon using the name of the file and its extension
---@param name string
---@return string, string?
function M.get_file_icon(name)
  local ext = name:match(".+%.(.*)$") or ""
  if shared_state.state.get_file_icon then
    local icon, _ = shared_state.state.get_file_icon(name, ext)
    return icon, _
  end

  if shared_state.config.on_get_file then
    local icon, color = shared_state.config.on_get_file(name, ext)
    return icon, color
  end

  return shared_state.config.file_icon.icon, shared_state.config.file_icon.hl_group
end

function M.setup_buffer_cleanup()
  local group = vim.api.nvim_create_augroup("WinBarBufferCleanup", { clear = true })


  vim.api.nvim_create_autocmd({ 'BufWipeout', 'BufDelete' }, {
    group = group,
    callback = function(args)
      local buf = args.buf
      shared_state.state.buffers[buf] = nil
    end
  })
end

return M
