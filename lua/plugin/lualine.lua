--- Fix an issue with the native neovim implementation
---
--- adding this as the source of the diff's, then
--- avoid the error: "Vim:E903: Too many files '/usr/bin/git'"
--- @return table? with the changes
local function diff_source()
  local gitsigns = vim.b.gitsigns_status_dict
  if gitsigns then
    return {
      added = gitsigns.added,
      modified = gitsigns.changed,
      removed = gitsigns.removed
    }
  end
  return nil
end

local colors = {
  blue       = '#80a0ff',
  cyan       = '#79dac8',
  black      = '#080808',
  white      = '#c6c6c6',
  red        = '#ff5189',
  violet     = '#f0bbff',
  full_green = '#a2ff9d',
  grey       = '#202030',
}

local bubbles_theme = {
  normal = {
    a = { fg = colors.black, bg = colors.violet },
    b = { fg = colors.white, bg = colors.grey },
    c = { fg = colors.white },
    x = { fg = colors.white },
    y = { fg = colors.white, bg = colors.grey },
  },

  insert = { a = { fg = colors.black, bg = colors.blue } },
  visual = { a = { fg = colors.black, bg = colors.cyan } },
  replace = { a = { fg = colors.black, bg = colors.red } },

  inactive = {
    a = { fg = colors.white, bg = colors.grey },
    b = { fg = colors.white, bg = colors.grey },
    c = { fg = colors.white },
  },
}

require('lualine').setup {
  options = {
    icons_enabled = true,
    theme = bubbles_theme,
    section_separators = { left = '', right = '' },
    component_separators = { left = '', right = '' },
  },
  always_divide_middle = true,
  always_show_tabline = true,
  -- Fix also the issue with having too much windows with lualine
  globalstatus = vim.go.laststatus == 3,
  extensions = { 'nvim-tree', 'neo-tree', 'fugitive' },
  sections = {
    lualine_a = { { 'mode', separator = { left = '' }, right_padding = 2 } },
    lualine_b = { 'filename', 'filesize', 'searchcount' },
    lualine_c = {
      {
        'branch',
        icon = '',
        color = { fg = colors.full_green, gui = 'bold' }
      },
      {
        'diff',
        symbols = { added = ' ', modified = '󰝤 ', removed = ' ' },
        source = diff_source,
        diff_color = {
          added = { fg = colors.green },
          modified = { fg = colors.orange },
          removed = { fg = colors.red },
        },
      }
    },
    lualine_x = {
      {
        'diagnostics',
        separator = { left = '', right = '' },
        right_padding = 3,
      },
      'encoding',
      'filetype',
      {
        'fileformat',
        symbols = {
          unix = 'LF',
          dos = 'CRLF',
          mac = 'CR',
        },
      },
      'lsp_status',
    },
    lualine_y = { 'progress' }, -- , 'codeium#GetStatusString' },
    lualine_z = { 'selectioncount', 'location', }
  },
  inactive_sections = {
    lualine_a = {},
    lualine_b = { 'progress' },
    lualine_c = {
      'filename',
      'filesize',
      {
        'diff',
        symbols = { added = ' ', modified = '󰝤 ', removed = ' ' },
        diff_color = {
          added = { fg = colors.green },
          modified = { fg = colors.orange },
          removed = { fg = colors.red },
        },
      },
    },
    lualine_x = {
      {
        'diagnostics',
        separator = { left = '', right = '' },
        right_padding = 3,
      },
      'location',
    },
    lualine_y = {},
    lualine_z = {}
  },
}
