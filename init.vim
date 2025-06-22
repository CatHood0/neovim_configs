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
require('color-picker').setup({
	["icons"] = { "", "   " },
	["border"] = "rounded", -- none | single | double | rounded | solid | shadow
	["keymap"] = { -- mapping example:
		["U"] = "<Plug>ColorPickerSlider5Decrease",
		["O"] = "<Plug>ColorPickerSlider5Increase",
	},
	["background_highlight_group"] = "Normal", -- default
	["border_highlight_group"] = "FloatBorder", -- default
  ["text_highlight_group"] = "Normal", --default
})
vim.cmd([[hi FloatBorder guibg=NONE]]) -- if you don't want weird border background colors around the popup.
EOF


lua require('alpha').setup(require('alpha.themes.theta').config)
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

" Translation 
" nnoremap <space>te viw:Translate <locale name><CR>
nnoremap <space>te viw:Translate es<CR>
lua require("translate").setup({})

lua << EOF
require 'window-picker'.setup({
    filter_rules = {
    include_current_win = false,
    autoselect_one = true,
    -- filter using buffer options
    bo = {
      -- if the file type is one of following, the window will be ignored
      filetype = { 'neo-tree', "neo-tree-popup", "notify" },
        -- if the buffer type is one of following, the window will be ignored
        buftype = { 'terminal', "quickfix" },
      },
    },
})
EOF

lua << EOF
-- IA
--[[
require('tabnine').setup({
  disable_auto_comment=true,
  accept_keymap="<S-Tab>",
  dismiss_keymap = "<C-]>",
  debounce_ms = 800,
  suggestion_color = {gui = "#808080", cterm = 244},
  exclude_filetypes = {"TelescopePrompt", "NvimTree"},
  log_file_path = nil, -- absolute path to Tabnine log file
  ignore_certificate_errors = false,
})
]]
EOF


" This avoid an issue where, when we confirm a suggestion selection
" this action breaks the completion, and add weird new lines after the
" change (unnecessarily)
inoremap <silent><expr> <cr> pumvisible() ? coc#_select_confirm()
                              \: "\<C-g>u\<CR>\<c-r>=coc#on_enter()\<CR>"
inoremap <silent><expr> <CR> coc#pum#visible() ? coc#pum#confirm()
                              \: "\<C-g>u\<CR>\<c-r>=coc#on_enter()\<CR>"

" =========== COC keys definition ===========
" These need to be here since are overrided by other plugins

" Make possible scroll into the suggestion menu using CTRL+J/K
" JUST INSERT MODE
imap <silent><expr> <C-j> coc#pum#visible() ? coc#pum#next(1) : "\<C-j>"
imap <silent><expr> <C-k> coc#pum#visible() ? coc#pum#prev(1) : "\<C-k>"

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
highlight CocHighlightText guibg=#3e5551 ctermbg=239  " Gris oscuro

function! ShowDocumentation()
  if CocAction('hasProvider', 'hover')
    call CocActionAsync('doHover')
  else
    call feedkeys('K', 'in')
  endif
endfunction
