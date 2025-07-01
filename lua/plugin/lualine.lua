require('lualine').setup {
  extensions = { 'nvim-tree', 'neo-tree', 'fugitive' },
  sections = {
    lualine_a = { 'mode' },
    lualine_b = { 'filename', 'filesize', 'searchcount' },
    lualine_c = { 'branch', 'diff', 'diagnostics' },
    lualine_x = { 'g:coc_status', 'encoding', 'filetype' },
    lualine_y = { 'g:coc_progress' }, -- , 'codeium#GetStatusString' },
    lualine_z = { 'selectioncount', 'location' }
  },
  inactive_sections = {
    lualine_a = {},
    lualine_b = { 'g:coc_status' },
    lualine_c = { 'filename', 'filesize', 'g:coc_git_status' },
    lualine_x = { 'diff', 'location' },
    lualine_y = {},
    lualine_z = {}
  },
}
