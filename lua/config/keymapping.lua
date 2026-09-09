local map = vim.keymap.set
local lsp = require("plugin.lsp.lsp")
local sorted_actions = require("core.code_action.native_sorted_code_actions")

-- ==================== Window Navigation ====================
map("n", "<c-k>", "<cmd>wincmd k<cr>", { silent = true, desc = "Move cursor to top windows (if available)" })
map("n", "<c-j>", "<cmd>wincmd j<cr>", { silent = true, desc = "Move cursor to bottom windows (if available)" })
map("n", "<c-h>", "<cmd>wincmd h<cr>", { silent = true, desc = "Move cursor to left windows (if available)" })
map("n", "<c-l>", "<cmd>wincmd l<cr>", { silent = true, desc = "Move cursor to right windows (if available)" })
-- removes some keymaps inserted by plugins
map("n", "n", "<nop>", { silent = true })
map("n", "<c-u>", "<nop>", { silent = true })
map("n", "<M-DOWN>", "<nop>", { silent = true })
map("n", "<M-UP>", "<nop>", { silent = true })

-- ==================== Window Resizing ====================
map("n", "<space>j", function()
  require("tmux").resize_bottom()
end, {
  silent = true,
  desc = "Decrease win size to bottom",
})
map("n", "<space>k", function()
  require("tmux").resize_top()
end, {
  silent = true,
  desc = "Increase win size to top",
})
map("n", "<space>h", function()
  require("tmux").resize_left()
end, {
  silent = true,
  desc = "Increase win size to left",
})

map("n", "<space>l", function()
  require("tmux").resize_right()
end, {
  silent = true,
  desc = "Decrease win size to right",
})

map("n", "<C-q>", "<cmd>vsplit<cr>", { silent = true, desc = "Open a new vertical window" })
map("n", "<C-q>v", "<cmd>split<cr>", { silent = true, desc = "Open a new horizontal window" })

-- ==================== Folding keymapping ====================
-- vim.keymap.set("n", "zz", function() vim.cmd("normal za") end, {
--   silent = true,
--   desc = "Toggle fold under cursor"
-- })
-- vim.keymap.set("n", "<TAB>", function() vim.cmd("normal za") end, {
--   silent = true,
--   desc = "Toggle fold under cursor"
-- })
--
-- vim.keymap.set("n", "zo", function() vim.cmd("normal zM") end, {
--   silent = true,
--   desc = "Close all folds"
-- })
-- vim.keymap.set("n", "zm", function() vim.cmd("normal zR") end, {
--   silent = true,
--   desc = "Open all folds"
-- })

-- ==================== Testing ====================
map("n", "<leader>tf", "<cmd>TestFile<cr>", { silent = true, nowait = false })
-- map('n', '<leader>tn', '<cmd>TestNearest<cr>', { silent = true, nowait = true })
-- map('n', '<leader>a', '<cmd>TestSuite<cr>', { silent = true })
-- map("n", "<leader>tl", "<cmd>TestLast<cr>", { silent = true })
map("n", "<leader>lss", "<cmd>LiveServerStart<cr>", { silent = true, desc = "Server: Toggle Live Server" })
map("n", "<leader>lsc", "<cmd>LiveServerClose<cr>", { silent = true, desc = "Server: Close Live Server" })
map("n", "<leader>nt", "<cmd>Neotest run file<cr>", { silent = true, desc = "Neotest: Run file tests" })
map("n", "<leader>nn", "<cmd>Neotest stop<cr>", { silent = true, desc = "Neotest: Stop running of test" })
map("n", "<leader>ns", "<cmd>Neotest summary<cr>", { silent = true, desc = "Neotest: Toggle summary" })

map('n', '<leader>jb', function()
  require('java').build.build_workspace()
end, { silent = true, desc = "Java: Build workspace" })

map('n', '<leader>jc', function()
  require('java').build.clean_workspace()
end, { silent = true, desc = "Java: Clean workspace cache" })

-- === Runner Commands ===
map('n', '<leader>jr', function()
  require('java').runner.built_in.run_app({})
end, { silent = true, desc = "Java: Run main class" })

map('n', '<leader>jR', function()
  local args = vim.fn.input("Arguments: ")
  require('java').runner.built_in.run_app(vim.split(args, " "))
end, { silent = true, desc = "Java: Run main with args" })

map('n', '<leader>js', function()
  require('java').runner.built_in.stop_app()
end, { silent = true, desc = "Java: Stop running application" })

map('n', '<leader>jl', function()
  require('java').runner.built_in.toggle_logs()
end, { silent = true, desc = "Java: Toggle runner logs" })

-- === Test Commands ===
-- Usando el mismo prefijo que tus tests existentes (leader + t)
-- pero con 'j' para Java específico
map('n', '<leader>tjf', function()
  require('java').test.run_current_class()
end, { silent = true, desc = "Java: Run current test class" })

map('n', '<leader>tjF', function()
  require('java').test.debug_current_class()
end, { silent = true, desc = "Java: Debug current test class" })

map('n', '<leader>tjn', function()
  require('java').test.run_current_method()
end, { silent = true, desc = "Java: Run current test method" })

map('n', '<leader>tjN', function()
  require('java').test.debug_current_method()
end, { silent = true, desc = "Java: Debug current test method" })

map('n', '<leader>tja', function()
  require('java').test.run_all_tests()
end, { silent = true, desc = "Java: Run all tests" })

map('n', '<leader>tjA', function()
  require('java').test.debug_all_tests()
end, { silent = true, desc = "Java: Debug all tests" })

map('n', '<leader>tjr', function()
  require('java').test.view_last_report()
end, { silent = true, desc = "Java: View last test report" })

-- === Profile Commands ===
map('n', '<leader>jp', function()
  require('java').profile.ui()
end, { silent = true, desc = "Java: Open profiles UI" })

-- === Refactor Commands ===
-- Usando el mismo prefijo que tus comandos de refactor existentes
map('n', '<leader>rv', function()
  require('java').refactor.extract_variable()
end, { silent = true, desc = "Java: Extract variable" })

map('n', '<leader>rV', function()
  require('java').refactor.extract_variable_all_occurrence()
end, { silent = true, desc = "Java: Extract variable (all occurrences)" })

map('n', '<leader>rc', function()
  require('java').refactor.extract_constant()
end, { silent = true, desc = "Java: Extract constant" })

map('n', '<leader>rm', function()
  require('java').refactor.extract_method()
end, { silent = true, desc = "Java: Extract method" })

map('n', '<leader>rf', function()
  require('java').refactor.extract_field()
end, { silent = true, desc = "Java: Extract field" })

-- === Settings Commands ===
map('n', '<leader>jj', function()
  require('java').settings.change_runtime()
end, { silent = true, desc = "Java: Change JDK version" })

map('n', '<leader>jm', function()
  require('java').runner.built_in.run_app({})
end, { silent = true, desc = "Java: Run main" })

-- === Atajo para ver información de la clase Java ===
map('n', '<leader>ji', function()
  vim.lsp.buf.hover()
end, { silent = true, desc = "Java: Show info" })

-- ==================== Debugging ====================
-- nvim-dap
map("n", "<leader>pp", function()
  require("persistent-breakpoints.api").toggle_breakpoint()
end, { silent = true, desc = "Debug: Toggle Breakpoint" })
map("n", "<leader>P", function()
  require("persistent-breakpoints.api").set_conditional_breakpoint()
end, {
  silent = true,
  desc = "Debug: Toggle Conditional Breakpoint",
})
map("n", "<leader>pl", function()
  require("persistent-breakpoints.api").set_log_point()
end, { silent = true, desc = "Debug: Toggle Log Point" })
map("n", "<leader>pc", function()
  require("persistent-breakpoints.api").clear_all_breakpoints()
end, { silent = true, desc = "Ends dap debugging process" })
map("n", "<leader>dc", "<cmd>DapContinue<cr>", { silent = true, desc = "Debug: Start/Continue" })
map("n", "<leader>di", "<cmd>DapStepInto<cr>", { silent = true, desc = "Debug: Step Into" })
map("n", "<leader>do", "<cmd>DapStepOver<cr>", { silent = true, desc = "Debug: Step Over" })
map("n", "<leader>du", "<cmd>DapStepOut<cr>", { silent = true, desc = "Debug: Step Out" })
map("n", "<leader>de", "<cmd>DapDisconnect<cr>", { silent = true, desc = "Ends dap debugging process" })
-- Toggle to see last session result. Without this, you can't see session output in case of unhandled exception.
-- map('n', '<F7>', require('dapui').toggle, { silent = true, desc = 'Debug: See last session result.' })

-- ==================== File Operations ====================
map("n", "<C-s>", "<cmd>w!<cr>", { silent = true, desc = "Save all workspace files" })
map("n", "<C-s>a", "<cmd>wall<cr>", { silent = true, desc = "Save all and quit of neovim" })
map(
  "n",
  "<space>qq",
  "<cmd>lua vim.lsp.buf.format({ timeout_ms = 2000 })<cr><cmd>SessionSave<cr><cmd>wqall<cr>",
  { silent = true, desc = "Format file, Save and quit storing the session" }
)
map("n", "<leader>gt", function()
  require("codecompanion").toggle({})
end, { silent = true, desc = "Toggles the AI chat buffer" })

-- ==================== Buffer Management ====================
-- Bufferline
map("n", "<space>m", "<cmd>BufferLineCycleNext<cr>", { silent = true, desc = "Focus the view on the next buffer" })
map("n", "<space>n", "<cmd>BufferLineCyclePrev<cr>", { silent = true, desc = "Focus the view on the previous buffer" })
map("n", "<Space>d", function()
  vim.api.nvim_command("bp|sp|bn|bd!")
end, { silent = true })

map("n", "<space>vc", "<cmd>BufferLineTogglePin<cr>", { silent = true, desc = "Deletes current buffer" })
map("n", "<space>vm", "<cmd>BufferLineMoveNext<cr>", { silent = true, desc = "Moves the buffer to the next index" })
map("n", "<space>vn", "<cmd>BufferLineMovePrev<cr>", { silent = true, desc = "Moves the buffer to the previous index" })

-- ==================== Search/Finding ====================
-- Telescope
map("n", "<C-p>", function()
  require("telescope.builtin").find_files({
    find_command = {
      "rg",
      "--files",
      "-g",
      "!.git", -- Pass '-w' flag to ripgrep for whole-word matching
    },
  })
end, { silent = true, desc = "Open search files popup" })
map("n", "<C-f>", function()
  require("telescope.builtin").current_buffer_fuzzy_find({
    sorter = require("telescope.sorters").get_fzy_sorter({}),
  })
end, { silent = true, desc = "Open local text search popup" })
map("n", "<leader>f", function()
  require("telescope.builtin").live_grep({
    -- Pass '-w' flag to ripgrep for whole-word matching
    -- additional_args = { '-w' },
  })
end, { silent = true, desc = "Open global text search popup" })

-- ==================== Sessions ====================
map("n", "<space>qs", "<cmd>AutoSession save<cr>", { silent = true, desc = "Save the session" })
map("n", "<space>ql", "<cmd>AutoSession restore<cr>", { silent = true, desc = "Restore to the last session" })
map(
  "n",
  "<space>qd",
  "<cmd>AutoSession delete<cr>",
  { silent = true, desc = "Delete current session of the workspace" }
)
map("n", "<space>qt", "<cmd>AutoSession search<cr>", { silent = true, desc = "Search sessions" })

-- ==================== File Tree ====================
map("n", "<C-a>", "<cmd>Neotree toggle<cr>", { silent = true, desc = "Open Tree explorer" })
-- map('n', '<C-a>', '<Cmd>CHADopen<CR>', { silent = true, desc = "Open Tree explorer" })

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
map(
  "n",
  "<space>tn",
  "<cmd>Telescope notify<cr>",
  { silent = true, nowait = true, desc = "Open notifications explorer" }
)

-- ==================== Git ====================
map("n", "<space>pp", "<cmd>DiffviewOpen<cr>", { silent = true, desc = "Open diff view" })
map("n", "<space>pc", "<cmd>DiffviewClose<cr>", { silent = true, desc = "Close diff views" })
map(
  "n",
  "<space>ph",
  "<cmd>DiffviewFileHistory<cr>",
  { silent = true, desc = "Open history of the differences of the file" }
)
map("n", "<space>gi", "<cmd>Neogit<cr>", { silent = true, desc = "Open Neogit popup" })
map("n", "<space>pu", vim.cmd.UndotreeToggle)
map("n", "<leader>lg", "<cmd>LazyGit<cr>", { silent = true, desc = "Open LazyGit popup" })

-- ==================== LSP Mappings ====================
-- This original map works good, but, does not show diagnostics when required.
-- Probably it needs more configuration to allow a native solution
-- map('n', '<space>w', function() vim.lsp.buf.hover(lsp.hover_opts) end, { silent = true, desc = "Show documentation" })
-- Setup keymaps
map("n", "<space>w", require("hover").hover, { desc = "hover.nvim" })
map("n", "<MouseMove>", require("hover").hover_mouse, { desc = "hover.nvim (mouse)" })
map("n", "<space>ca", sorted_actions.code_action, { silent = true, desc = "Code actions" })
map("n", "<space>fi", "<cmd>Trouble diagnostics toggle focus=true<cr>", { silent = true, desc = "Toggle diagnostics" })
map("n", "<C-d>d", vim.lsp.buf.definition, { silent = true, nowait = true, desc = "Go to definition" })
map("n", "<C-d>i", vim.lsp.buf.type_definition, { silent = true, nowait = true, desc = "Go to type definition" })
map("n", "<C-w>", vim.lsp.buf.references, { silent = true, nowait = true, desc = "Show references" })
map("n", "<space>fo", function()
  vim.lsp.buf.format({ timeout_ms = 2000 })
end, { silent = true, nowait = true, desc = "Format code" })
map(
  "n",
  "<space>re",
  vim.lsp.buf.rename,
  { silent = true, nowait = true, desc = "Rename all references to the symbol under the cursor" }
)

-- ==================== Flutter ====================
map("n", "<space>fr", "<cmd>FlutterRun<cr>", { desc = "Run your flutter app", silent = true, nowait = true })
map("n", "<leader>q", "<cmd>FlutterQuit<cr>", { desc = "Stop your flutter app", silent = true, nowait = true })
map("n", "<leader>re", "<cmd>FlutterReload<cr>", { desc = "Run hot reload", silent = true, nowait = true })
map(
  "n",
  "<leader>rf",
  "<cmd>FlutterRestart<cr>",
  { desc = "Run Full Restart of the app", silent = true, nowait = true }
)
map("n", "<leader>sp", "<cmd>FlutterSuper<cr>", { silent = true, nowait = true })
map(
  "n",
  "<leader>eg",
  "<cmd>FlutterPubGet<cr>",
  { desc = "Run pub get to restart dependencies", silent = true, nowait = true }
)
map(
  "n",
  "<leader>ll",
  "<cmd>FlutterLogToggle<cr>",
  { desc = "Open/Close flutter log buffer", silent = true, nowait = true }
)
map(
  "n",
  "<leader>lc",
  "<cmd>FlutterLogClear<cr>",
  { desc = "Clear the flutter log buffer", silent = true, nowait = true }
)
-- map('n', '<leader>fmo', '<cmd>FlutterEmulators<cr>', { silent = true, nowait = true })
-- map('n', '<space>op', '<cmd>FlutterDevTools<cr>', { silent = true, nowait = true })
-- map('n', '<leader>tou', '<cmd>FlutterOutlineToggle<cr>', { silent = true, nowait = true })

-- ==================== C++ or C ====================
map("n", "<leader>cd", "<cmd>CMakeClean<cr>", {
  silent = true,
  nowait = true,
  desc = "Run C++ project in Debug Mode",
})
map("n", "<leader>cs", "<cmd>CMakeSettings<cr>", {
  silent = true,
  nowait = true,
  desc = "Opens the current settings of the project",
})
map("n", "<leader>ct", "<cmd>CMakeRunTest<cr>", {
  silent = true,
  nowait = true,
  desc = "Run Tests from C++ project",
})
map("n", "<leader>cl", "<cmd>CMakeClean<cr>", {
  silent = true,
  nowait = true,
  desc = "Install all the dependencies in CMakeLists.txt",
})
map("n", "<leader>ci", "<cmd>CMakeInstall<cr>", {
  silent = true,
  nowait = true,
  desc = "Install all the dependencies in CMakeLists.txt",
})
map("n", "<leader>cg", "<cmd>CMakeBuild<cr>", {
  silent = true,
  nowait = true,
  desc = "Generate compile_commands.json",
})
map("n", "<leader>cb", "<cmd>CMakeBuild<cr>", {
  silent = true,
  nowait = true,
  desc = "Build C++ project using CMAKE",
})
map("n", "<leader>cr", "<cmd>CMakeRun<cr>", {
  silent = true,
  nowait = true,
  desc = "Run C++ project using CMAKE",
})

map("n", "<leader>mn", "<CMD>Neominimap Toggle<CR>", { silent = true, desc = "Toggle minimap" })

-- ==================== Insert Mode Mappings ====================
map("i", "<C-n>", "<nop>")
map("i", "<C-p>", "<nop>")

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
