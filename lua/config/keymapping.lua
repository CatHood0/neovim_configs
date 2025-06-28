local map = vim.keymap.set

-- ==================== Window Navigation ====================
map('n', '<c-k>', '<cmd>wincmd k<cr>', { silent = true })
map('n', '<c-j>', '<cmd>wincmd j<cr>', { silent = true })
map('n', '<c-h>', '<cmd>wincmd h<cr>', { silent = true })
map('n', '<c-l>', '<cmd>wincmd l<cr>', { silent = true })
map('n', 'n', '<nop>', { silent = true })

-- ==================== Testing ====================
map('n', '<leader>t', '<cmd>TestNearest<cr>', { silent = true })
map('n', '<leader>T', '<cmd>TestFile<cr>', { silent = true })
map('n', '<leader>a', '<cmd>TestSuite<cr>', { silent = true })
map('n', '<leader>l', '<cmd>TestLast<cr>', { silent = true })

-- ==================== Debugging ====================
-- nvim-dap
map('n', '<space>tb', '<cmd>DapToggleBreakpoint<cr>')
map('n', '<F4>', '<cmd>DapContinue<cr>')
map('n', '<F5>', '<cmd>DapDisconnect<cr>')
map('n', '<space>tm', '<cmd>DapContinue<cr>')

-- ==================== File Operations ====================
map('n', '<C-q>', '<cmd>q<cr>')
map('n', '<C-Q>', '<cmd>qa!<cr>')
map('n', '<C-s>', '<cmd>wall<cr>', { silent = true })
map('n', '<space>qq', '<cmd>Format<cr><cmd>wqall<cr><cmd>SessionSave<cr>', { silent = true })

-- ==================== Buffer Management ====================
-- Bufferline
map('n', '<space>m', '<cmd>BufferLineCycleNext<cr>', { silent = true })
map('n', '<space>n', '<cmd>BufferLineCyclePrev<cr>', { silent = true })
map('n', '<space>d', '<cmd>bdelete!<cr>', { silent = true })
map('n', '<space>vc', '<cmd>BufferLineTogglePin<cr>', { silent = true })
map('n', '<space>vm', '<cmd>BufferLineMoveNext<cr>', { silent = true })
map('n', '<space>vn', '<cmd>BufferLineMovePrev<cr>', { silent = true })

-- ==================== Search/Finding ====================
-- Telescope
map('n', '<C-p>', function()
  require('telescope.builtin').find_files({ find_command = { 'rg', '--files', '-g', '!.git' } })
end)
map('n', '<C-f>', function()
  require('telescope.builtin').current_buffer_fuzzy_find({
    sorter = require('telescope.sorters').get_fzy_sorter({})
  })
end)
map('n', '<leader>f', '<cmd>lua require("telescope.builtin").live_grep()<cr>')

-- ==================== Sessions ====================
map('n', '<space>qs', '<cmd>SessionSave<cr>', { silent = true })
map('n', '<space>ql', '<cmd>SessionRestore<cr>', { silent = true })
map('n', '<space>qd', '<cmd>SessionDelete<cr>', { silent = true })

-- ==================== File Tree ====================
map('n', '<C-a>', '<cmd>Neotree toggle<cr>', { silent = true })

-- ==================== Formatting ====================
map('n', '<space>fo', '<cmd>Format<cr>', { silent = true })

-- ==================== Line Movement ====================
-- Idk exactly why, mapping these keys using vim.api.keyset
-- applies them, but, them not work as i expect
--map('n', '<S-j>', '<cmd>MoveLine 1<cr>', { silent = true })
--map('n', '<S-k>', '<cmd>MoveLine -1<cr>', { silent = true })
--map('n', '<S-l>', '<cmd>MoveHChar 1<cr>', { silent = true })
--map('n', '<S-h>', '<cmd>MoveHChar -1<cr>', { silent = true })
--map('v', '<S-h>', '<cmd>MoveHBlock -1<cr>', { silent = true })
--map('x', '<S-j>', '<cmd>MoveBlock 1<cr>', { silent = true })
--map('x', '<S-k>', '<cmd>MoveBlock -1<cr>', { silent = true })
--map('v', '<S-l>', '<cmd>MoveHBlock 1<cr>', { silent = true })
-- Only using vimscripting makes them works exactly as they should
vim.cmd([[
nnoremap <silent> <S-j> :MoveLine 1<CR>
nnoremap <silent> <S-k> :MoveLine -1<CR>
nnoremap <silent> <S-l> :MoveHChar 1<CR>
nnoremap <silent> <S-h> :MoveHChar -1<CR>
vnoremap <silent> <S-h> :MoveHBlock -1<CR>
xnoremap <silent> <S-j> :MoveBlock 1<CR>
xnoremap <silent> <S-k> :MoveBlock -1<CR>
vnoremap <silent> <S-l> :MoveHBlock 1<CR>
]])

-- =================== Notifications ===================
map('n', '<space>tn', '<cmd>Telescope notify<cr>', { silent = true, nowait = true })

-- ==================== Git ====================
map('n', '<space>pp', '<cmd>DiffviewOpen<cr>', { silent = true })
map('n', '<space>pc', '<cmd>DiffviewClose<cr>', { silent = true })
map('n', '<space>ph', '<cmd>DiffviewFileHistory<cr>', { silent = true })
map('n', '<space>gi', '<cmd>Neogit<cr>', { silent = true })

-- ==================== Window Resizing ====================
map('n', '<space>h', '<cmd>lua require("tmux").resize_left()<cr>')
map('n', '<space>j', '<cmd>lua require("tmux").resize_bottom()<cr>')
map('n', '<space>k', '<cmd>lua require("tmux").resize_top()<cr>')
map('n', '<space>l', '<cmd>lua require("tmux").resize_right()<cr>')

-- ==================== Custom Mappings ====================
map('n', 'w', '<nop>', { silent = true })
map('n', '<C-w><C-w>', '<nop>', { silent = true })
map('n', '<C-q>', '<nop>')
map('n', '<C-q>', '<cmd>vsplit<cr>')
map('n', '<C-q>v', '<cmd>split<cr>')
map('v', 'n', '<nop>')
map('n', '<S-+>', '<nop>')

-- ==================== COC Mappings ====================
map('n', '<space>w', '<cmd>lua vim.fn.ShowDocumentation()<cr>', { silent = true })
map('n', '<space>ca', '<Plug>(coc-codeaction-cursor)', { silent = true })
map('n', '<space>cs', '<Plug>(coc-codeaction-source)', { silent = true })
map('n', '<space>fi', '<cmd>Trouble diagnostics toggle focus=true<cr>', { silent = true })
map('n', '<C-d>d', '<Plug>(coc-definition)', { silent = true, nowait = true })
map('n', '<C-d>i', '<Plug>(coc-type-definition)', { silent = true, nowait = true })
map('n', '<C-w>', '<Plug>(coc-references)', { silent = true, nowait = true })

-- ==================== Flutter ====================
map('n', '<space>fr', '<cmd>CocCommand flutter.run<cr>', { silent = true })
map('n', '<space>fq', '<cmd>CocCommand flutter.dev.quit<cr>', { silent = true })
map('n', '<space>tou', '<cmd>CocCommand flutter.toggleOutline<cr>', { silent = true })
map('n', '<space>fmo', '<cmd>CocCommand flutter.devices<cr>', { silent = true })
map('n', '<space>ro', '<cmd>CocCommand flutter.dev.hotReload<cr>', { silent = true })
map('n', '<space>re', '<cmd>CocCommand flutter.dev.hotRestart<cr>', { silent = true })
map('n', '<space>sp', '<cmd>CocCommand flutter.lsp.restart<cr>', { silent = true })
map('n', '<space>op', '<cmd>CocCommand flutter.dev.openDevToolsProfiler<cr>', { silent = true })
map('n', '<space>fn', '<cmd>CocCommand workspace.renameCurrentFile<cr>', { silent = true })
map('n', '<space>eg', '<cmd>CocCommand flutter.pub.get<cr>', { silent = true })
map('n', '<space>co', '<cmd>CocCommand flutter.dev.openDevLog<cr>', { silent = true })
map('n', '<space>cl', '<cmd>CocCommand flutter.dev.clearDevLog<cr>', { silent = true })

-- ==================== Insert Mode Mappings ====================
map('i', '<C-n>', '<nop>')
map('i', '<C-p>', '<nop>')

-- ==================== Codeium (AI) ====================
-- Note: These need to remain as Vimscript expressions
--[[ vim.cmd([[
    imap <script><silent><nowait><expr> <TAB> codeium#Accept()
    imap <script><silent><nowait><expr> <C-h> codeium#AcceptNextWord()
    imap <script><silent><nowait><expr> <C-l> codeium#AcceptNextLine()
    imap <C-;>   <Cmd>call codeium#CycleCompletions(1)<CR>
    imap <C-,>   <Cmd>call codeium#CycleCompletions(-1)<CR>
    imap <C-x>   <Cmd>call codeium#Clear()<CR>
  ]]

-- ==================== FZF Configuration ====================
-- These need to remain in Vimscript
vim.cmd([[
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

    if has("termguicolors")
      set termguicolors
    endif

    let g:fzf_layout = { 'window': { 'width': 0.8, 'height': 0.8, 'highlight': 'Normal' } }
]])
