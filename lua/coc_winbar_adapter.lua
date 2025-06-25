local M = {}
local state = {
  last_winbar = "",
  current_path = "",
  update_pending = false,
  hl_groups_defined = false
}

local diagnostic_severity = {
  [vim.diagnostic.severity.ERROR] = "DiagnosticError",
  [vim.diagnostic.severity.WARN] = "DiagnosticWarn",
  [vim.diagnostic.severity.INFO] = "DiagnosticInfo",
  [vim.diagnostic.severity.HINT] = "DiagnosticHint",
}

local default_config = {
  enabled = true,
  icons = true,
  separator = "»",
  folder_hl_group = "Normal",
  file_hl_color = "Normal",
  show_diagnostic = false,
  update_in_insert = true,
  depth = {
    limit = nil,
    separator = "",
  },
  update_events = {
    'BufEnter',
    'DirChanged',
    'InsertLeave',
    'DiagnosticChanged'
  },
  folder_icon = {
    icon = "",
    color = "#7ebae4",
    hl_group = "folder"
  },
  file_icon = {
    fallback_icon = "",
    fallback_color = "#6d8086",
    hl_group = "file"
  },
  -- Callbacks obligatorios para iconos
  on_get_folder = nil, -- function(name) => icon, hl_group
  on_get_file = nil,   -- function(name, ext) => icon, hl_group

  -- Callbacks opcionales para personalización avanzada
  on_format_element = nil, -- function(part, ext, is_file, is_last) => formatted_string
}

local config = vim.deepcopy(default_config)

-- Definir grupos de resaltado personalizados
local function define_hl_groups()
  if state.hl_groups_defined then return end

  vim.api.nvim_set_hl(0, config.folder_icon.hl_group, {
    fg = config.folder_icon.color,
  })

  vim.api.nvim_set_hl(0, config.file_icon.hl_group, {
    fg = config.file_icon.fallback_color
  })

  state.hl_groups_defined = true
end

local function get_folder_icon(name)
  if config.on_get_folder then
    local icon, color = config.on_get_folder(name)
    return icon, color
  end

  return config.folder_icon.icon, config.folder_icon.hl_group
end

local function get_file_icon(name)
  if config.on_get_file then
    local ext = name:match(".+%.(.*)$") or ""
    local icon, color = config.on_get_file(name, ext)
    return icon, color
  end

  return config.file_icon.fallback_icon, config.file_icon.hl_group
end

local function get_diagnostic()
  if config.show_diagnostics then return nil end
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

-- Formatear elemento individual
local function format_element(part, ext, is_file, is_last, is_part_break)
  if is_part_break and not is_file then return "" end
  if config.on_format_element then
    local formatted = config.on_format_element(part, ext, is_file, is_last)
    if formatted then return formatted end
  end

  local icon, icon_color
  if is_file then
    icon, icon_color = get_file_icon(part)
    icon = icon or config.file_icon.fallback_icon
    icon_color = icon_color or config.file_icon.hl_group
  else
    icon, icon_color = get_folder_icon(part)
    icon = icon or config.folder_icon.icon
    icon_color = icon_color or config.folder_icon.hl_group
  end
  local element = ""

  if icon and icon ~= "" and icon_color ~= "" then
    element = string.format("%%#%s#%s %%*", icon_color, icon)
  end
  local color = not icon_color and "" or is_file and config.file_hl_color or config.folder_hl_group
  if is_last and is_file then
    local diag = get_diagnostic()
    color = diag ~= nil and diag or config.color_files
  else
    color = config.color_dirs
  end
  element = element .. string.format("%%#%s#%s", color, part)

  return element
end

-- Núcleo de generación de winbar
local function generate_winbar()
  if not config.enabled then return "" end
  state.current_path = ""

  local file_path = vim.fn.expand('%:p:~:.')
  if file_path == "" then return "" end

  local parts = {}
  for part in file_path:gmatch("[^/]+") do
    table.insert(parts, part)
  end

  local partBreak = false
  if config.depth and config.depth.limit and #parts > config.depth.limit then
    partBreak = true
    parts = { "…", unpack(parts, #parts - config.depth.limit + 1) }
  end

  local winbar_parts = {}
  for i, part in ipairs(parts) do
    state.current_path = state.current_path .. (i > 1 and "/" or "") .. part
    local is_file = (i == #parts)
    local ext = part:match(".+%.(.*)$") or ""
    local element = format_element(part, ext, is_file, i == #parts, partBreak)
    table.insert(winbar_parts, element)
    if partBreak then
      partBreak = false
      table.insert(winbar_parts,
        string.format("%%#%s#%s", "Comment",
          "…  " .. (config.depth.separator ~= nil and config.depth.separator or "") .. "  "))
    else
      if i < #parts then
        table.insert(winbar_parts, string.format("%s", " " .. config.separator .. " "))
      end
    end
  end
  return "  " .. table.concat(winbar_parts, "")
end

local function update_winbar()
  if state.update_pending then return end

  state.update_pending = true
  vim.schedule(function()
    if vim.api.nvim_get_mode().mode == 'i' and not config.update_in_insert then
      state.update_pending = false
      return
    end

    local new_winbar = generate_winbar()
    if new_winbar ~= state.last_winbar then
      vim.opt.winbar = new_winbar
      state.last_winbar = new_winbar
    end
    state.update_pending = false
  end)
end

-- API pública
function M.setup(user_config)
  vim.api.nvim_set_hl(0, "DiagnosticError", { fg = "#ff0000" })
  vim.api.nvim_set_hl(0, "DiagnosticWarn", { fg = "#ffff00" })
  vim.api.nvim_set_hl(0, "DiagnosticInfo", { fg = "#00ffff" })
  vim.api.nvim_set_hl(0, "DiagnosticHint", { fg = "#ffffff" })
  config = vim.tbl_deep_extend("force", default_config, user_config or {})
  define_hl_groups()

  if config.enabled then
    local group = vim.api.nvim_create_augroup("WinBarUpdater", {})
    vim.api.nvim_clear_autocmds({ group = group })

    for _, event in ipairs(config.update_events) do
      vim.api.nvim_create_autocmd(event, {
        group = group,
        callback = update_winbar
      })
    end

    -- Comandos personalizados
    vim.api.nvim_create_user_command("WinbarToggle", function()
      config.enabled = not config.enabled
      update_winbar()
      print("Winbar " .. (config.enabled and "enabled" or "disabled"))
    end, {})

    vim.api.nvim_create_user_command("WinbarRefresh", function()
      update_winbar()
      print("Winbar refreshed")
    end, {})

    update_winbar()
  end
end

-- Para depuración
function M._get_config()
  return config
end

function M._get_state()
  return state
end

return M
