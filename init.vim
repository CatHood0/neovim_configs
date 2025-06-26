" Settings
source ~/.config/nvim/config/settings.vim
source ~/.config/nvim/config/mapping.vim
source ~/.config/nvim/config/plugins.vim
" Plugins
source ~/.config/nvim/plugin/git/git_plugins.vim
source ~/.config/nvim/plugin/statusline/statusline_plugin.vim
source ~/.config/nvim/plugin/autosession/autosession_plugin.vim
source ~/.config/nvim/plugin/themes/themes_plugin.vim
source ~/.config/nvim/plugin/neotree/neotree_plugin.vim
source ~/.config/nvim/plugin/indent_line/indent_line_plugin.vim
source ~/.config/nvim/plugin/notify/notify_plugin.vim
source ~/.config/nvim/plugin/notify/noice.vim
source ~/.config/nvim/plugin/toggleterm/toggleterm_plugin.vim
source ~/.config/nvim/plugin/cursors/cursors_plugins.vim
" source ~/.config/nvim/plugin/tabs/barbar_plugin.vim
source ~/.config/nvim/plugin/tabs/bufferline_plugin.vim
source ~/.config/nvim/plugin/treesitter/treesitter_plugin.vim
source ~/.config/nvim/plugin/cmp/cmp_plugin.vim
source ~/.config/nvim/plugin/telescope/telescope_plugin.vim
source ~/.config/nvim/plugin/dart_dap/dap_plugin.vim

lua << EOF
require('ultimate-autopair').setup({
    event={'InsertEnter','CmdlineEnter'},
    branch='v0.6', --recommended as each new version will have breaking changes
  }
)
EOF

lua << EOF
require('dashboard').setup {
  theme = 'hyper',
}
EOF

lua require('pubspec-assist').setup()

lua << EOF
require('tmux').setup({
 navigation = {
   -- cycles to opposite pane while navigating into the border
   cycle_navigation = true,
   -- enables default keybindings (C-hjkl) for normal mode
   enable_default_keybindings = false,
   -- prevents unzoom tmux when navigating beyond vim border
   persist_zoom = true,
 },
 resize = {
   -- enables default keybindings (A-hjkl) for normal mode
   enable_default_keybindings = false,
   -- sets resize steps for x axis
   resize_step_x = 4,
   -- sets resize steps for y axis
   resize_step_y = 4,
 }
})
EOF

" This avoid an issue where, when we confirm a suggestion selection
" this action breaks the completion, and add weird new lines after the
" change (unnecessarily)
inoremap <silent><expr> <CR> coc#pum#visible() ? coc#pum#confirm()
                              \: "\<C-g>u\<CR>\<c-r>=coc#on_enter()\<CR>"

" =========== COC keys definition ===========
" These need to be here since are overrided by other plugins

" Make possible scroll into the suggestion menu using CTRL+J/K
" JUST INSERT MODE
inoremap <silent><expr> <C-j> coc#pum#visible() ? coc#pum#next(1) : "\<C-j>"
inoremap <silent><expr> <C-k> coc#pum#visible() ? coc#pum#prev(1) : "\<C-k>"
" Make possible show the suggestion menu just pressing CTRL+Spacekey
imap <silent><expr> <C-Space> coc#refresh()
 
" Add `:Format` command to format current buffer
command! -nargs=0 Format :call CocActionAsync('format')

" Add `:Fold` command to fold current buffer.
command! -nargs=? Fold :call     CocActionAsync('fold', <f-args>)

" Add `:OR` command for organize imports of the current buffer
command! -nargs=0 OR   :call     CocActionAsync('runCommand', 'editor.action.organizeImport')

" Highlight the symbol and its references when holding the cursor
autocmd CursorHold * silent call CocActionAsync('highlight')

" Add background highlighting for cursor holding
highlight CocHighlightText guibg=#4F4451 ctermbg=239 " Gris oscuro

function! ShowDocumentation()
  if CocAction('hasProvider', 'hover')
    call CocActionAsync('doHover')
  else
    call feedkeys('K', 'in')
  endif
endfunction

" =========== COC to Native LSP diagnostic implementation ===========
lua << EOF
local diagnostic_adapter = require("diagnostics/coc_diagnostic_adapter")
diagnostic_adapter.setup()
EOF

" =========== Native winbar implementation ===========
lua << EOF
local devicons_ok, devicons = pcall(require, 'nvim-web-devicons')
if not devicons_ok then
  vim.notify("No se pudo cargar nvim-web-devicons", vim.log.levels.WARN)
  return
end

-- Configuración básica de devicons (esto debe ir ANTES de usarlo)
devicons.setup({
  override = {
    folder = {
      icon = "",
      color = "#7ebae4",
      name = "folder"
    }
  }
})

local winbar = require("winbar/nbreadcrumbs")

winbar.setup({
  enabled = true,
  separator = "»",
  show_diagnostic = true,
  on_get_folder = function(name)
    local icon, color = devicons.get_icon("folder", "", { default = true })
    return icon, color
  end, 
  on_get_file = function(name, ext)
    local icon, color = devicons.get_icon(name, ext, { default = true })
    return icon, color
  end,
})
EOF
