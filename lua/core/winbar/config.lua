---@class WinbarOpts
---@field enabled boolean? Enable/disable the winbar
---@field lsp_enabled boolean? Enable/disable the lsp support into the winbar
---@field icons boolean? Show icons for file and folder names
---@field icons_provider string? Set the provider of the icons. Supported: [nvim-web-devicons, mini-icons]
---@field separator string Separator? between path elements (e.g., ">")
---@field folder_hl_group string? Highlight group for folders
---@field separator_hl_color string? Highlight group for separators
---@field file_hl_color string? Highlight group for current file
---@field show_diagnostic boolean? Show diagnostic icons in winbar
---@field update_in_insert boolean? Update winbar in insert mode
---@field exclude_winbar_from string[]? Buffer types where winbar is disabled
---@field depth DepthConfig? Depth settings for long paths
---@field update_events string[]? Events triggering winbar updates
---@field folder_icon IconConfig? Folder icon settings
---@field file_icon IconConfig? File icon settings
---@field on_get_folder fun(name: string)?:string,string? Custom folder icon/color
---@field on_get_file fun(name: string, ext: string)?:string,string? Custom file icon/color
---@field on_format_element fun(part: string, ext: string?, is_file: boolean, is_last: boolean)?:string Formatter

---@class DepthConfig
---@field limit integer? Max path elements (nil = no limit)
---@field separator string Truncation separator (e.g., "...")

---@class IconConfig
---@field icon string Icon character
---@field color string Color code
---@field hl_group string Highlight group

local winbar_opts = {
  enabled = true,
  icons = true,
  lsp_enabled = true,
  separator = ">",
  icons_provider = nil,
  folder_hl_group = "Normal",
  file_hl_color = "Normal",
  separator_hl_color = "Comment",
  show_diagnostic = false,
  update_in_insert = true,

  exclude_winbar_from = {
    "bin",             -- Binary buffers
    "help",            -- Help windows
    "nofile",          -- Buffers not associated with a file
    "neo-tree",        -- neo-tree plugin
    "NvimTree",        -- NvimTree plugin
    "TelescopePrompt", -- Telescope prompt
    "quickfix",        -- Quickfix window
    "noice",           -- noice.nvim plugin
    "nui",             -- nui.nvim internal buffers
  },

  depth = {
    limit = nil,    -- Maximum number of elements to show (nil = no limit)
    separator = "", -- Separator for truncated paths (e.g., "...docs/file")
  },

  update_events = {
    "BufEnter",    -- When entering a buffer
    "BufLeave",    -- When leaving a buffer
    "DirChanged",  -- When changing directories
    "CursorMoved", -- When moving the cursor
    "CursorMovedI",
    "CursorHold",
    "LspAttach",
    "LspDetach",
    "LspProgress",
    "WinEnter",          -- When entering in a new window
    "WinLeave",          -- When leaving a window
    "InsertLeave",       -- When leaving insert mode
    "DiagnosticChanged", -- When diagnostics change
    "WinResized",
    "VimResized",
    "BufWritePost",
  },

  folder_icon = {
    icon = "", -- Default folder icon
    color = "#7ebae4", -- Default color
    hl_group = "Normal",
  },

  file_icon = {
    icon = "", -- Default icon for files without specific icon
    color = "#6d8086", -- Default color
    hl_group = "Normal",
  },

  on_get_folder = nil,
  on_get_file = nil,
  on_format_element = nil,
}

return winbar_opts
