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
  always_divide_middle = true, -- When set to true, left sections i.e. 'a','b' and 'c'
  -- can't take over the entire statusline even
  -- if neither of 'x', 'y' or 'z' are present.
  always_show_tabline = true,
  globalstatus = false, -- enable global statusline (have a single statusline
  -- at bottom of neovim instead of one for  every window).
  -- This feature is only available in neovim 0.7 and higher.
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
      'encoding', 'filetype'
    },
    lualine_y = { 'progress', 'lsp_status' }, -- , 'codeium#GetStatusString' },
    lualine_z = { 'selectioncount', 'location' }
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
      'location'
    },
    lualine_y = {},
    lualine_z = {}
  },
}
