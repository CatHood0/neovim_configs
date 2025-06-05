lua << EOF
 require('lualine').setup{
   extensions = { 'nvim-tree', 'neo-tree', 'fugitive' },
   sections = {
     lualine_a = { 'mode' },
     lualine_b = { 'filename', 'filesize', 'searchcount' },
     lualine_c = { 'g:coc_git_status', 'diff', 'diagnostics' },
     lualine_x = { 'g:coc_status', 'encoding', 'filetype' }, 
     lualine_y = { 'g:coc_progress', 'tabnine' },
     lualine_z = { 'selectioncount', 'location' }
   },
   inactive_sections = {
     lualine_a = {},
     lualine_b = {},
     lualine_c = {'filename'},
     lualine_x = {'location'},
     lualine_y = {},
     lualine_z = {}
   },
} 
EOF
