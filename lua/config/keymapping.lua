local map = vim.keymap.set
local lsp = require('plugin.lsp.lsp')
local sorted_actions = require('core.code_action.native_sorted_code_actions')

-- ==================== Window Navigation ====================
map('n', '<c-k>', '<cmd>wincmd k<cr>', { silent = true, desc = "Move cursor to top windows (if available)" })
map('n', '<c-j>', '<cmd>wincmd j<cr>', { silent = true, desc = "Move cursor to bottom windows (if available)" })
map('n', '<c-h>', '<cmd>wincmd h<cr>', { silent = true, desc = "Move cursor to left windows (if available)" })
map('n', '<c-l>', '<cmd>wincmd l<cr>', { silent = true, desc = "Move cursor to right windows (if available)" })
map('n', 'n', '<nop>', { silent = true })
map('n', '<c-u>', '<nop>', { silent = true })

-- ==================== Window Resizing ====================
map('n', '<space>k', function()
  require("tmux").resize_bottom()
end, {
  silent = true,
  desc = "Decrease win size to bottom"
})
map('n', '<space>j', function()
  require("tmux").resize_top()
end, {
  silent = true,
  desc = "Increase win size to top"
})
map('n', '<space>h', function()
  require("tmux").resize_left()
end, {
  silent = true,
  desc = "Increase win size to left"
})

map('n', '<space>l', function()
  require("tmux").resize_right()
end, {
  silent = true,
  desc = "Decrease win size to right"
})

map('n', '<C-q>', '<cmd>vsplit<cr>', { silent = true, desc = "Open a new vertical window" })
map('n', '<C-q>v', '<cmd>split<cr>', { silent = true, desc = "Open a new horizontal window" })

-- ==================== Folding keymapping ====================
vim.keymap.set("n", "zz", function() vim.cmd("normal! za") end, {
  silent = true,
  desc = "Toggle fold under cursor"
})
vim.keymap.set("n", "<TAB>", function() vim.cmd("normal! za") end, {
  silent = true,
  desc = "Toggle fold under cursor"
})

vim.keymap.set("n", "zo", function() vim.cmd("normal! zM") end, {
  silent = true,
  desc = "Close all folds"
})
vim.keymap.set("n", "zm", function() vim.cmd("normal! zR") end, {
  silent = true,
  desc = "Open all folds"
})

-- ==================== Testing ====================
map('n', '<leader>t', '<cmd>TestFile<cr>', { silent = true, nowait = false })
-- map('n', '<leader>tn', '<cmd>TestNearest<cr>', { silent = true, nowait = true })
-- map('n', '<leader>a', '<cmd>TestSuite<cr>', { silent = true })
map('n', '<leader>l', '<cmd>TestLast<cr>', { silent = true })

-- ==================== Debugging ====================
-- nvim-dap
map('n', '<space>tb', '<cmd>DapToggleBreakpoint<cr>', { silent = true, desc = "Toggle dap breakpoint" })
map('n', '<F5>', '<cmd>DapDisconnect<cr>', { silent = true, desc = "Ends dap debugging process" })
map('n', '<space>tm', '<cmd>DapContinue<cr>', { silent = true, desc = "Continue to the next dap breakpoint" })

-- ==================== File Operations ====================
-- map('n', '<C>', '<cmd>qa!<cr>', { silent = true, desc = "Force quit of neovim" })
map('n', '<C-s>', '<cmd>wall<cr>', { silent = true, desc = "Save all workspace files" })
map('n', '<C-s>a', '<cmd>wqall<cr>', { silent = true, desc = "Save all and quit of neovim" })
map('n', '<space>qq', '<cmd>Format<cr><cmd>wqall<cr><cmd>SessionSave<cr>',
  { silent = true, desc = "Format file, Save and quit storing the session" })

-- ==================== Buffer Management ====================
-- Bufferline
map('n', '<space>m', '<cmd>BufferLineCycleNext<cr>', { silent = true, desc = "Focus the view on the next buffer" })
map('n', '<space>n', '<cmd>BufferLineCyclePrev<cr>', { silent = true, desc = "Focus the view on the previous buffer" })
map('n', '<space>d', '<cmd>bdelete!<cr>', { silent = true })
map('n', '<space>vc', '<cmd>BufferLineTogglePin<cr>', { silent = true, desc = "Deletes current buffer" })
map('n', '<space>vm', '<cmd>BufferLineMoveNext<cr>', { silent = true, desc = "Moves the buffer to the next index" })
map('n', '<space>vn', '<cmd>BufferLineMovePrev<cr>', { silent = true, desc = "Moves the buffer to the previous index" })

-- ==================== Search/Finding ====================
-- Telescope
map('n', '<C-p>', function()
  require('telescope.builtin').find_files({ find_command = { 'rg', '--files', '-g', '!.git' } })
end, { silent = true, desc = "Open search files popup" })
map('n', '<C-f>', function()
  require('telescope.builtin').current_buffer_fuzzy_find({
    sorter = require('telescope.sorters').get_fzy_sorter({})
  })
end, { silent = true, desc = "Open local text search popup" })
map('n', '<leader>f', '<cmd>lua require("telescope.builtin").live_grep()<cr>',
  { silent = true, desc = "Open global text search popup" })

-- ==================== Sessions ====================
map('n', '<space>qs', '<cmd>SessionSave<cr>', { silent = true, desc = "Save the session" })
map('n', '<space>ql', '<cmd>SessionRestore<cr>', { silent = true, desc = "Restore to the last session" })
map('n', '<space>qd', '<cmd>SessionDelete<cr>', { silent = true, desc = "Delete current session of the workspace" })

-- ==================== File Tree ====================
map('n', '<C-a>', '<cmd>Neotree toggle<cr>', { silent = true, desc = "Open Tree explorer" })

-- ==================== Line Movement ====================
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
map('n', '<space>tn', '<cmd>Telescope notify<cr>', { silent = true, nowait = true, desc = "Open notifications explorer" })

-- ==================== Git ====================
map('n', '<space>pp', '<cmd>DiffviewOpen<cr>', { silent = true, desc = "Open diff view" })
map('n', '<space>pc', '<cmd>DiffviewClose<cr>', { silent = true, desc = "Close diff views" })
map('n', '<space>ph', '<cmd>DiffviewFileHistory<cr>',
  { silent = true, desc = "Open history of the differences of the file" })
map('n', '<space>gi', '<cmd>Neogit<cr>', { silent = true, desc = "Open Neogit popup" })

-- ==================== LSP Mappings ====================
-- This original map works good, but, does not show diagnostics when required.
-- Probably it needs more configuration to allow a native solution
-- map('n', '<space>w', function() vim.lsp.buf.hover(lsp.hover_opts) end, { silent = true, desc = "Show documentation" })
-- Setup keymaps
map("n", "<space>w", require("hover").hover, { desc = "hover.nvim" })
map('n', '<MouseMove>', require('hover').hover_mouse, { desc = "hover.nvim (mouse)" })
map('n', '<space>ca', sorted_actions.code_action, { silent = true, desc = "Code actions" })
map('x', '<space>ca', sorted_actions.code_action, { silent = true, desc = "Code actions" })
map('n', '<space>fi', '<cmd>Trouble diagnostics toggle focus=true<cr>', { silent = true, desc = "Toggle diagnostics" })
map('n', '<C-d>d', vim.lsp.buf.definition, { silent = true, nowait = true, desc = "Go to definition" })
map('n', '<C-d>i', vim.lsp.buf.type_definition, { silent = true, nowait = true, desc = "Go to type definition" })
map('n', '<C-w>', vim.lsp.buf.references, { silent = true, nowait = true, desc = "Show references" })
map('n', '<space>fo', vim.lsp.buf.format, { silent = true, nowait = true, desc = "Format code" })
map('n', '<space>re', vim.lsp.buf.rename,
  { silent = true, nowait = true, desc = "Rename all references to the symbol under the cursor" })

-- ==================== Flutter ====================
map('n', '<space>fr', '<cmd>FlutterRun<cr>', { silent = true, nowait = true })
map('n', '<space>fq', '<cmd>FlutterQuit<cr>', { silent = true, nowait = true })
map('n', '<space>tou', '<cmd>FlutterOutlineToggle<cr>', { silent = true, nowait = true })
map('n', '<space>fmo', '<cmd>FlutterDevices<cr>', { silent = true, nowait = true })
map('n', '<space>ro', '<cmd>FlutterHotReload<cr>', { silent = true, nowait = true })
map('n', '<space>fre', '<cmd>FlutterRestart<cr>', { silent = true, nowait = true })
map('n', '<space>sp', '<cmd>FlutterSuper<cr>', { silent = true, nowait = true })
map('n', '<space>op', '<cmd>FlutterDevTools<cr>', { silent = true, nowait = true })
map('n', '<space>eg', '<cmd>FlutterPubGet<cr>', { silent = true, nowait = true })
map('n', '<space>co', '<cmd>FlutterLog<cr>', { silent = true, nowait = true })
map('n', '<space>cl', '<cmd>FlutterClearLog<cr>', { silent = true, nowait = true })


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
