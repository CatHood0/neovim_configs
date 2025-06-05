
nmap <silent> <c-k> :wincmd k<CR>
nmap <silent> <c-j> :wincmd j<CR>
nmap <silent> <c-h> :wincmd h<CR>
nmap <silent> <c-l> :wincmd l<CR>
nnoremap <silent> n <Nop>
" COC
"inoremap <silent><expr> <TAB>
"      \ coc#pum#visible() ? coc#_select_confirm() :
"      \ coc#expandableOrJumpable() ? "\<C-r>=coc#rpc#request('doKeymap', ['snippets-expand-jump',''])\<CR>" :
"      \ CheckBackSpace() ? "\<TAB>" :
"      \ coc#refresh()

"function! CheckBackSpace() abort
"  let col = col('.') - 1
"  return !col || getline('.')[col - 1]  =~# '\s'
"endfunction

" vimspector
" mnemonic 'di' = 'debug inspect' (pick your own, if you prefer!)
" for normal mode - the word under the cursor
"nmap <space>be <Plug>VimspectorBalloonEval
" for visual mode, the visually selected text
"xmap <space>be <Plug>VimspectorBalloonEval
"nmap <space>br <Plug>VimspectorBreakpoints
"nmap <space>tb <Plug>VimspectorToggleBreakpoint
"nmap <space>vc <Plug>VimspectorContinue
"nmap <space>vs <Plug>VimspectorStop
"nmap <space>vss <Plug>VimspectorRestart
"nmap <space>vp <Plug>VimspectorPause

"nmap <c-Ñ> <Plug>VimspectorJumpToNextBreakpoint
"nmap <c-ñ> <Plug>VimspectorJumpToPreviousBreakpoint

nmap <silent> <leader>t :TestNearest<CR>
nmap <silent> <leader>T :TestFile<CR>
nmap <silent> <leader>a :TestSuite<CR>
nmap <silent> <leader>l :TestLast<CR>

" Neogit 
"noremap <silent> <space>gi <cmd>:Neogit<CR>
"noremap <silent> <space>gf <cmd>:Neogit fetch<CR>
"noremap <silent> <space>gl <cmd>:Neogit pull<CR>
"noremap <silent> <space>gu <cmd>:Neogit push<CR>
"noremap <silent> <space>gc <cmd>:Neogit commit<CR>
"noremap <silent> <space>gb <cmd>:Neogit branch<CR>
"noremap <silent> <space>gd <cmd>:Neogit diff<CR>
"noremap <silent> <space>gm <cmd>:Neogit merge<CR>

"Alternative file searhing with Fzf mappings
"nmap <C-P> :Files<CR>
"nmap <C-f> :Lines<CR>

" Debugger
" nvim-dap
nmap <space>tb <cmd>:DapToggleBreakpoint<cr>
nmap <F4> <cmd>:DapContinue<cr>
nmap <F5> <cmd>:DapDisconnect<cr>
nmap <space>tm <cmd>:DapContinue<cr>

" Quit
nnoremap <C-q> :q<cr>
nnoremap <C-Q> :qa!<cr>
" Barbar 
nmap <silent> <space>m :BufferNext<CR>
nmap <silent> <space>n :BufferPrevious<CR>
nmap <silent> <space>d  :BufferDelete<CR>
nmap <silent> <space>1  :BufferFirst<CR>
nmap <silent> <space>2  :BufferLast<CR>
nmap <silent> <space>vs  :BufferMoveStart<CR>
nmap <silent> <space>vm  :BufferMoveNext<CR>
nmap <silent> <space>vn  :BufferMovePrevious<CR>
" Bufferline
"nmap <silent> <space>m   :BufferLineCycleNext<CR>
"nmap <silent> <space>n   :BufferLineCyclePrev<CR>
"nmap <silent> <space>d   :bdelete!<CR>
"nmap <silent> <space>vc  :BufferLineTogglePin<CR>
"nmap <silent> <space>vm  :BufferLineMoveNext<CR>
"nmap <silent> <space>vn  :BufferLineMovePrev<CR>
nmap <S-+> <Nop>
" FZF
command! -bang -nargs=* Rg
  \ call fzf#vim#grep(
  \   'rg --column --line-number --no-heading --color=always --smart-case -- '.shellescape(<q-args>), 1,
  \   fzf#vim#with_preview(), <bang>0)

function! RipgrepFzf(query, fullscreen)
  let command_fmt =  'rg --column --line-number --no-heading --color=always --smart-case -- %s || true'
  let initial_command = printf(command_fmt, shellescape(a:query))
  let reload_command = printf(command_fmt, '{q}')
  let spec = {'options': ['--phony', '--query', a:query, '--bind', 'change:reload:'.reload_command]}
  call fzf#vim#grep(initial_command, 1, fzf#vim#with_preview(spec), a:fullscreen)
endfunction

command! -nargs=* -bang RG call RipgrepFzf(<q-args>, <bang>0)

"let g:fzf_action = {
"      \ 'alt-t': 'tab split',
"      \ 'alt-s': 'split',
"      \ 'alt-v': 'vsplit',
"      \ 'ctrl-t': 'tab split',
"      \ 'ctrl-s': 'split',
"      \ 'ctrl-v': 'vsplit'
"    \ }

" Customize fzf colors to match your color scheme
" - fzf#wrap translates this to a set of `--color` options
let g:fzf_colors =
\ { 'fg':      ['fg', 'Normal'],
  \ 'bg':      ['bg', 'Normal'],
  \ 'hl':      ['fg', 'Comment'],
  \ 'fg+':     ['fg', 'CursorLine', 'CursorColumn', 'Normal'],
  \ 'bg+':     ['bg', 'CursorLine', 'CursorColumn'],
  \ 'hl+':     ['fg', 'Statement'],
  \ 'info':    ['fg', 'PreProc'],
  \ 'border':  ['fg', 'Ignore'],
  \ 'prompt':  ['fg', 'Conditional'],
  \ 'pointer': ['fg', 'Exception'],
  \ 'marker':  ['fg', 'Keyword'],
  \ 'spinner': ['fg', 'Label'],
  \ 'header':  ['fg', 'Comment'] }
" Enable true color support if your terminal supports it
if has("termguicolors")
  set termguicolors
endif
let g:fzf_layout = { 'window': { 'width': 0.8, 'height': 0.8, 'highlight': 'Normal' } }
" For other commands, you can specify layout directly
"command! -bang -nargs=* Files
"      \ call fzf#vim#files(<q-args>, {'options': '--layout=reverse --info=inline'}, <bang>0)

" Activate if you want to use Signify
" Jump though hunks
" nmap <space>gj <plug>(signify-next-hunk)
" nmap <space>gk <plug>(signify-prev-hunk)

let g:dart_format_on_save = 0 " Pass "1" if you want automatic format on save current buffer
let g:dartfmt_options = ['--fix', '--line-length 90']
let g:dart_style_guide = 2
" Decomment if you want to show git changes on files
"let g:signify_sign_show_count = 0
"let g:signify_sign_show_text = 1
"let g:signify_sign_change = '~'

let g:lsc_auto_map = v:true
let g:auto_session_root_dir = "~/.nvim_sessions" 
" Telescope
" Removed '--hidden' because load too many files
nnoremap <C-p> <cmd>lua require'telescope.builtin'.find_files({ find_command = {'rg', '--files', '-g', '!.git' }})<cr>
nnoremap <C-f> <cmd>lua require("telescope.builtin").current_buffer_fuzzy_find({ sorter = require('telescope.sorters').get_fzy_sorter({})})<cr>
"nnoremap <C-f> <cmd>lua require("telescope.builtin").current_buffer_fuzzy_find({ sorter = require('telescope.sorters').get_substr_matcher({})})<cr>
nnoremap <leader>f <cmd>lua require'telescope.builtin'.live_grep()<cr>

" Sessions
nnoremap <silent> <space>qs <cmd>:SessionSave<CR>
nnoremap <silent> <space>ql <cmd>:SessionRestore<CR>
nnoremap <silent> <space>qd <cmd>:SessionDelete<CR>

" Tree
map <silent> <C-a> <CMD>Neotree toggle<CR>
"nmap <C-a> <Cmd>CocCommand explorer<CR>
" Custom actions
nnoremap <silent> <C-s> <CMD>:wall<CR>
" Activate if you wanna a hotkey that format file on save (could be slow on large files)
nnoremap <silent> <space>qq <CMD>:Format<CR><CMD>:wqall<CR><cmd>:SessionSave<CR>
nnoremap <silent> <space>fo <CMD>:Format<CR> 
" Move line keymaps
nnoremap <silent> <S-j> :MoveLine 1<CR>
nnoremap <silent> <S-k> :MoveLine -1<CR>
nnoremap <silent> <S-l> :MoveHChar 1<CR>
nnoremap <silent> <S-h> :MoveHChar -1<CR>
" For move line while selecting blocks
vnoremap <silent> <S-h> :MoveHBlock -1<CR>
xnoremap <silent> <S-j> :MoveBlock 1<CR>
xnoremap <silent> <S-k> :MoveBlock -1<CR>
vnoremap <silent> <S-l> :MoveHBlock 1<CR>
"nmap <S-h> <Plug>GoNSMLeft
"nmap <S-l> <Plug>GoNSMRight

" Git diff view
nnoremap <silent> <space>pp :DiffviewOpen<CR>
nnoremap <silent> <space>pc :DiffviewClose<CR>

nnoremap <silent> <space>pi <cmd>PickColor<cr>

" Terminal
nnoremap <silent> <space>tt <CMD>:ToggleTerm<CR>

" Resize windows
nnoremap <space>h <cmd>lua require("tmux").resize_left()<cr>
nnoremap <space>j <cmd>lua require("tmux").resize_bottom()<cr>
nnoremap <space>k <cmd>lua require("tmux").resize_top()<cr>
nnoremap <space>l <cmd>lua require("tmux").resize_right()<cr>

" Custom
nnoremap <silent> w <Nop>
nnoremap <silent> <C-w><C-w> <Nop>
nmap <C-q> <Nop>
nmap <C-q> <CMD>:vsplit<CR>
nmap <C-q>v <CMD>:split<CR>
vmap n <Nop>

" COc mapping
nnoremap <silent> <space>w :call ShowDocumentation()<CR>
nnoremap <silent> <space>ca <Plug>(coc-codeaction-cursor)
nnoremap <silent> <space>cs <Plug>(coc-codeaction-source)
nnoremap <silent> <space>cf  <Plug>(coc-fix-current)
nmap <C-d>i <Plug>(coc-type-definition)
nmap <leader>w <Plug>(coc-references)
nnoremap <silent> <space>fi <CMD>:CocDiagnostics<CR> 
nnoremap <silent> <C-d>d <Plug>(coc-definition)
" Flutter commands
nnoremap <silent> <space>fr <cmd>:CocCommand flutter.run<cr>
nnoremap <silent> <space>fq <cmd>:CocCommand flutter.dev.quit<cr>

nnoremap <silent> <space>tou <cmd>:CocCommand flutter.toggleOutline<cr>
nnoremap <silent> <space>fmo <cmd>:CocCommand flutter.devices<cr>
nnoremap <silent> <space>ro <cmd>:CocCommand flutter.dev.hotReload<cr>
nnoremap <silent> <space>re <cmd>:CocCommand flutter.dev.hotRestart<cr>
nnoremap <silent> <space>sp <cmd>:CocCommand flutter.lsp.restart<cr>
nnoremap <silent> <space>op <cmd>:CocCommand flutter.dev.openDevToolsProfiler<cr>
nnoremap <silent> <space>fn <cmd>:CocCommand workspace.renameCurrentFile<cr>
nnoremap <silent> <space>eg <cmd>:CocCommand flutter.pub.get<cr>
nnoremap <silent> <space>co <cmd>:CocCommand flutter.dev.openDevLog<CR>
nnoremap <silent> <space>cl <cmd>:CocCommand flutter.dev.clearDevLog<cr>
" nnoremap <silent> <space>cc  <Plug>(coc-codeaction-cursor)
" nmap <silent><leader>g <Plug>(coc-definition)
" nmap <leader>t <Plug>(coc-type-definition)
" nmap <leader>r <Plug>(coc-rename)
" Remap keys for applying codeAction to the current buffer.
" nmap <leader>d  <Plug>(coc-codeaction)
" nmap <leader>u  <Plug>(coc-codeaction-source)
" nmap <leader>k  <Plug>(coc-codeaction-selected)w
" nmap <leader>j  <Plug>(coc-codeaction-line)
" nmap <leader>h  <Plug>(coc-codeaction-cursor)
imap  <C-n> <Nop>
imap  <C-p> <Nop>
