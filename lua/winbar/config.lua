local winbar_opts = {
  enabled = true,
  icons = true,
  separator = "»",
  folder_hl_group = "Normal",
  file_hl_color = "Normal",
  show_diagnostic = false,
  update_in_insert = true,
  use_nui = true,
  exclude_winbar_from = {
    "bin",  -- remove for toggleterm
    "help", -- remove for help window
    "nofile",
    "neo-tree",
    "NvimTree",
    "TelescopePrompt",
    "quickfix",
    'noice',
    'nui',
  },
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
  on_press_folder = nil,
  on_press_file = nil,
  on_hover = nil,
}

return winbar_opts
