-- Default configuration for the Winbar plugin
-- All these options can be overridden when calling setup()
local winbar_opts = {
  -- Enable/disable the winbar completely
  enabled = true,

  -- Show icons next to file and folder names
  icons = true,

  -- Separator between path elements (e.g., home » documents » file)
  separator = ">",

  -- Highlight group for folders in the path
  folder_hl_group = "Normal",

  -- Highlight group for current file (last element)
  file_hl_color = "Normal",

  -- Highlight group for the separators
  separator_hl_color = "Comment",

  -- Show diagnostic icons (errors, warnings) in the winbar
  show_diagnostic = false,

  -- Update winbar while in insert mode
  update_in_insert = true,

  -- List of buffer types where winbar will be disabled
  exclude_winbar_from = {
    "bin",             -- Binary buffers
    "help",            -- Help windows
    "nofile",          -- Buffers not associated with a file
    "neo-tree",        -- neo-tree plugin
    "NvimTree",        -- NvimTree plugin
    "TelescopePrompt", -- Telescope prompt
    "quickfix",        -- Quickfix window
    'noice',           -- noice.nvim plugin
    'nui',             -- nui.nvim internal buffers
  },

  -- Depth configuration for long paths
  depth = {
    limit = nil,    -- Maximum number of elements to show (nil = no limit)
    separator = "", -- Separator for truncated paths (e.g., "...docs/file")
  },

  -- Events that trigger winbar updates
  update_events = {
    'BufEnter',         -- When entering a buffer
    'DirChanged',       -- When changing directories
    'InsertLeave',      -- When leaving insert mode
    'DiagnosticChanged' -- When diagnostics change
  },

  -- Folder icon configuration
  folder_icon = {
    icon = "", -- Default folder icon
    color = "#7ebae4", -- Default color
    hl_group = "Normal" -- Custom highlight group
  },

  -- File icon configuration
  file_icon = {
    fallback_icon = "", -- Default icon for files without specific icon
    fallback_color = "#6d8086", -- Default color
    hl_group = "Normal" -- Custom highlight group
  },

  -- Function to get custom icon and color for folders
  -- @param name: folder name
  -- @return icon, hl_group
  on_get_folder = nil,

  -- Function to get custom icon and color for files
  -- @param name: file name
  -- @param ext: file extension
  -- @return icon, hl_group
  on_get_file = nil,

  -- Function to format individual winbar elements
  -- @param part: element text (file/folder name)
  -- @param ext: file extension (for files only)
  -- @param is_file: boolean, true if file
  -- @param is_last: boolean, true if last element
  -- @return formatted string
  on_format_element = nil,

  -- ============== These ones just works with nui ==============

  -- Callback when clicking a folder in winbar
  -- @param path: full folder path
  on_press_folder = nil,

  -- Callback when clicking a file in winbar
  -- @param path: full file path
  on_press_file = nil,

  -- Callback when hovering over winbar element
  -- @param path: element path
  -- @param is_file: boolean, true if file
  on_hover = nil,
}

return winbar_opts
