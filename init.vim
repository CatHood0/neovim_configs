set wrap
set number
set cursorline
set smartcase
set noswapfile
set scrolloff=10
set iskeyword+=-
set wrapmargin=10
set showcmd
set cmdheight=2 "more space in the neovim command line for displaying messages
set showmatch
set hlsearch
set showtabline=2                         " always show tabs
set smartcase                        " smart case
set smartindent                      " make indenting smarter again
set splitbelow                       " force all horizontal splits to go below current window
set splitright                       " force all vertical splits to go to the right of current window
set history=1000 " Remenber 1000 lines
set clipboard+=unnamedplus
" auto completition on tab
set wildmenu
set wildmode=longest:full,full
set wildignore=*.docx,*.jpg,*.png,*.gif,*.pdf,*.pyc,*.exe,*.flv,*.img,*.xlsx
set nobackup
set autoindent
set colorcolumn=120
set textwidth=120
set scrollbind 
set undofile
set incsearch
set expandtab
set tabstop=2
set softtabstop=0
set shiftwidth=2
set mouse=a
set encoding=utf-8
set hidden
set nowritebackup
set updatetime=300
set shortmess+=c
set termguicolors
syntax on
filetype plugin indent on
" Spelling correction
" set spell spelllang=en_us
set laststatus=2
let g:netrw_browsex_viewer="chrome"
set encoding=utf-8
set nowritebackup
set updatetime=300
set background=dark " or light if you want light mode

call plug#begin()
Plug 'rmagatti/auto-session'
Plug 'L3MON4D3/LuaSnip', {'tag': 'v2.*', 'do': 'make install_jsregexp'}
Plug 'neovim/nvim-lspconfig'	
Plug 'hrsh7th/nvim-cmp'
" Intellisense
Plug 'petertriho/cmp-git'
Plug 'saadparwaiz1/cmp_luasnip'
Plug 'rafamadriz/friendly-snippets'	
Plug 'hrsh7th/cmp-nvim-lsp'
Plug 'hrsh7th/cmp-buffer'
Plug 'hrsh7th/cmp-path'
Plug 'hrsh7th/cmp-cmdline'
Plug 'onsails/lspkind.nvim'
" LSP tools preconfigured
Plug 'akinsho/flutter-tools.nvim'
Plug 'nvim-lua/plenary.nvim'
Plug 'stevearc/dressing.nvim' 
" IA Asistant 
Plug 'codota/tabnine-nvim', { 'do': './dl_binaries.sh' }
Plug 'mfussenegger/nvim-dap' 
Plug 'nvim-neo-tree/neo-tree.nvim'
" Window Tabs 
Plug 'nvim-tree/nvim-web-devicons' 
Plug 'lewis6991/gitsigns.nvim' 
Plug 'romgrk/barbar.nvim'
Plug 's1n7ax/nvim-window-picker', { 'version' : '2.*' }  
Plug 'tpope/vim-sensible'
Plug 'nvim-lualine/lualine.nvim'
Plug 'rcarriga/nvim-notify'
Plug 'zeioth/garbage-day.nvim', { 'event' : 'VeryLazy' }
Plug 'folke/noice.nvim'
Plug 'nvimtools/none-ls.nvim'
Plug 'MunifTanjim/nui.nvim' 
Plug 'lukas-reineke/indent-blankline.nvim'
" Actions Hints
Plug 'roobert/action-hints.nvim'
Plug 'booperlv/nvim-gomove'
Plug 'echasnovski/mini.cursorword', { 'branch': 'stable' }
" General snippets - also relevant for Flutter
Plug 'honza/vim-snippets'
" Log coloring - SEE IF HELPFUL
Plug 'mtdl9/vim-log-highlighting'
Plug 'nvim-lua/plenary.nvim'
Plug 'nvim-telescope/telescope.nvim', { 'tag': '0.1.*' }
Plug 'NeogitOrg/neogit'
Plug 'sindrets/diffview.nvim'
" Adds information about what changed to the file at the place of line numbers
" Plug 'mhinz/vim-signify'
Plug 'nvim-tree/nvim-web-devicons' " Recommended (for coloured icons)
Plug 'akinsho/bufferline.nvim' 
" Open and close brackets automatically
Plug 'jiangmiao/auto-pairs'
" Colors brackets
Plug 'frazrepo/vim-rainbow'
" Help with surrounding stuff
Plug 'tpope/vim-surround'
" Terminal
Plug 'akinsho/toggleterm.nvim', { 'tag' : '2.*'}
Plug 'junegunn/fzf.vim'
Plug 'junegunn/fzf', { 'do': { -> fzf#install() } }
Plug 'BurntSushi/ripgrep'
Plug 'williamboman/nvim-lsp-installer'
" Multi cursor
Plug 'mg979/vim-visual-multi'
" Check gramma
Plug 'rhysd/vim-grammarous'
Plug 'ckipp01/stylua-nvim', { 'run' : 'cargo install stylua' }
" Tree sitter
Plug 'nvim-treesitter/nvim-treesitter' 
  
" Theme
Plug 'ellisonleao/gruvbox.nvim'
call plug#end()
colorscheme gruvbox

" FLUTTER AND NERDTREE
let mapleader=","

" OPTIONAL Type jj to exit insert mode quickly.
"inoremap jj <Esc>
"tnoremap jj <c-\><c-n>
" Use ctrl-[hjkl] to select the active split!

" Moving between splitted windows
nmap <silent> <c-k> :wincmd k<CR>
nmap <silent> <c-j> :wincmd j<CR>
nmap <silent> <c-h> :wincmd h<CR>
nmap <silent> <c-l> :wincmd l<CR>

" Flutter commands
nnoremap <silent> <space>fr <cmd>:FlutterRun<cr>
nnoremap <silent> <space>fq <cmd>:FlutterQuit<cr>
nnoremap <silent> <space>fd <cmd>:FlutterDevices<cr>
nnoremap <silent> <space>fe <cmd>:FlutterEmulators<cr>
nnoremap <silent> <space>fro <cmd>:FlutterReload<cr>
nnoremap <silent> <space>fre <cmd>:FlutterRestart<cr>
nnoremap <silent> <space>fsp <cmd>:FlutterLspRestart<cr>
nnoremap <silent> <space>fx <cmd>:FlutterReanalyze<cr>
nnoremap <silent> <space>fn <cmd>:FlutterRename<cr>
nnoremap <silent> <space>fg <cmd>:FlutterPubGet<cr>
nnoremap <silent> <space>fgu <cmd>:FlutterPubUpgrade<cr>
nnoremap <silent> <space>ff <cmd>:FlutterLogClear<cr>

" Neogit 
noremap <silent> <space>gi <cmd>:Neogit<CR>
noremap <silent> <space>gf <cmd>:Neogit fetch<CR>
noremap <silent> <space>gl <cmd>:Neogit pull<CR>
noremap <silent> <space>gu <cmd>:Neogit push<CR>
noremap <silent> <space>gc <cmd>:Neogit commit<CR>
noremap <silent> <space>gb <cmd>:Neogit branch<CR>
noremap <silent> <space>gd <cmd>:Neogit diff<CR>
noremap <silent> <space>gm <cmd>:Neogit merge<CR>

"Alternative file searhing with Fzf mappings
"nmap <C-P> :Files<CR>
"nmap <space>l :Lines<CR>
"nmap <space>h :History<CR>

" Quit
nnoremap <C-q> :q<cr>
nnoremap <C-Q> :qa!<cr>
nnoremap <silent> <C-L> :BufferNext<CR>
nnoremap <silent> <space>d  :BufferDelete<CR>
nnoremap <silent> <space>1  :BufferFirst<CR>
nnoremap <silent> <space>2  :BufferLast<CR>

" Terminal
nnoremap <silent> <C-m> :ToggleTerm<CR>

" FZF
command! -bang -nargs=* Rg
  \ call fzf#vim#grep(
  \   'rg --column --line-number --no-heading --color=always --smart-case -- '.shellescape(<q-args>), 1,
  \   fzf#vim#with_preview(), <bang>0)

function! RipgrepFzf(query, fullscreen)
  let command_fmt = 'rg --column --line-number --no-heading --color=always --smart-case -- %s || true'
  let initial_command = printf(command_fmt, shellescape(a:query))
  let reload_command = printf(command_fmt, '{q}')
  let spec = {'options': ['--phony', '--query', a:query, '--bind', 'change:reload:'.reload_command]}
  call fzf#vim#grep(initial_command, 1, fzf#vim#with_preview(spec), a:fullscreen)
endfunction

command! -nargs=* -bang RG call RipgrepFzf(<q-args>, <bang>0)

let g:fzf_action = {
      \ 'alt-t': 'tab split',
      \ 'alt-s': 'split',
      \ 'alt-v': 'vsplit',
      \ 'ctrl-t': 'tab split',
      \ 'ctrl-s': 'split',
      \ 'ctrl-v': 'vsplit'
  \ }

" Activate if you want to use Signify
" Jump though hunks
" nmap <space>gj <plug>(signify-next-hunk)
" nmap <space>gk <plug>(signify-prev-hunk)

" Vim Rainbow
au FileType dart,ts,java,c,cpp call rainbow#load()

let g:dart_format_on_save = 1
let g:dartfmt_options = ['--fix', '--line-length 80']
let g:dart_style_guide = 2

" Decomment if you want to show git changes on files
"let g:signify_sign_show_count = 0
"let g:signify_sign_show_text = 1
"let g:signify_sign_change = '~'

let g:barbar_auto_setup = v:false 
let g:lsc_auto_map = v:true
let g:rainbow_guifgs = ['#d8d83e', '#d8653e', '6f3ed8', '#d83e93', 'd8743e']
let g:rainbow_ctermfgs = ['lightblue', 'lightgreen', 'yellow', 'red']
let g:auto_session_root_dir = "/home/cathood/.config/nvim/sessions" 
" Telescope
nnoremap <C-p> <cmd>Telescope find_files<cr>
nnoremap <C-f> <cmd>Telescope live_grep<cr>
nnoremap <silent> <C-d>d <Cmd>lua require("telescope.builtin").lsp_definitions()<CR>

" Show code actions
nnoremap <silent> <space>ca <cmd>lua vim.lsp.buf.code_action()<CR>

" Sessions
nnoremap <silent> <space>qs <cmd>:SessionSave<CR>
nnoremap <silent> <space>ql <cmd>:SessionRestore<CR>
nnoremap <silent> <space>qd <cmd>:SessionDelete<CR>

" Tree
nnoremap <silent> <C-a> <CMD>Neotree toggle<CR>

" Custom actions
nnoremap <silent> <C-s> <CMD>lua vim.lsp.buf.format()<CR><CMD>:wall<CR>
nnoremap <silent> <C-q> <CMD>lua vim.lsp.buf.format()<CR><CMD>:wqall<CR><cmd>:SessionSave<CR>
" nnoremap <silent> <A-F> <CMD>lua vim.lsp.buf.format()<CR>
" Go move 
nmap <S-h> <Plug>GoNSMLeft
nmap <S-j> <Plug>GoNSMDown
nmap <S-k> <Plug>GoNSMUp
nmap <S-l> <Plug>GoNSMRight


lua require("nvim-lsp-installer").setup {} 

lua << EOF
require("bufferline").setup{
	options = {
		hover = {
			enabled = true,
			delay = 200,
			reveal = {'close'}
		},
		diagnostics_indicator = function(count, level, diagnostics_dict, context)
			local icon = level:match("error") and " " or " "
			return " " .. icon .. count
		end
	}
}
EOF

" Setup all dependencies that needed
lua << EOF
 require('lualine').setup{
 sections = { 
   lualine_a = { 'mode' },
   lualine_b = { 'filename' },
   lualine_c = { 'branch', 'diff', 'diagnostics' },
   lualine_x = { 'encoding', 'fileformat', 'filetype' }, 
   lualine_y = { 'lsp_progress' , 'tabnine' }, 
   lualine_z = { 'progress' , 'localtion' },
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

lua << EOF
-- Move line
require("gomove").setup {
  -- whether or not to map default key bindings, (true/false)
  map_defaults = false,
  -- whether or not to reindent lines moved vertically (true/false)
  reindent = true,
  -- whether or not to undojoin same direction moves (true/false)
  undojoin = true,
  -- whether to not to move past end column when moving blocks horizontally, (true/false)
  move_past_end_col = false,
}
EOF

lua << EOF
-- IA
require('tabnine').setup({
  disable_auto_comment=true,
  accept_keymap="<Tab>",
  dismiss_keymap = "<C-]>",
  debounce_ms = 800,
  suggestion_color = {gui = "#808080", cterm = 244},
  exclude_filetypes = {"TelescopePrompt", "NvimTree"},
  log_file_path = nil, -- absolute path to Tabnine log file
})
EOF

lua << EOF
-- Formatter
local  null_ls = require("null-ls") 
local formatting = null_ls.builtins.formatting
local diagnostics = null_ls.builtins.diagnostics
local augroup = vim.api.nvim_create_augroup("LspFormatting", {})

null_ls.setup({
  debug = false,
  sources = {
    formatting.stylua,
    formatting.cljstyle,
    diagnostics.clj_kondo,
  },
  on_attach = function(client, bufnr)
    if client.supports_method("textDocument/formatting") then
      vim.api.nvim_clear_autocmds({ group = augroup, buffer = bufnr })
      vim.api.nvim_create_autocmd("BufWritePre", {
        group = augroup,
        buffer = bufnr,
        callback = function()
          vim.lsp.buf.format()
        end,
      })
    end
  end,
})
EOF

lua << EOF
local telescope = require('telescope')
telescope.load_extension("noice")
telescope.load_extension("notify")
telescope.load_extension("flutter")
telescope.setup{
    previewer = true,
	  defaults = {
      vimgrep_arguments = {
        "rg",
        "--color=never",
        "--no-heading",
        "--with-filename",
        "--line-number",
        "--column",
        "--smart-case",
        "--ignore-file=" .. vim.fn.expand("$HOME") .. "/.fdignore"
      },
      prompt_prefix = " ",
      --prompt_prefix = "🔍, ",
      selection_caret = " ",
      entry_prefix = "  ",
      initial_mode = "insert",
      selection_strategy = "reset",
      sorting_strategy = "ascending",
      layout_strategy = "horizontal",
      preview = {
        treesitter = true
      },
      layout_config = {
        prompt_position = "top",
        width = 0.87,
        height = 0.80,
        preview_cutoff = 120,
        horizontal = {mirror = false, preview_cutoff = 1},
      },
      file_sorter = require("telescope.sorters").get_fuzzy_file,
      generic_sorter = require("telescope.sorters").get_generic_fuzzy_sorter,
      path_display = {"truncate"}, -- path_display = {"absolute"},
      winblend = 0,
      border = {},
      borderchars = {"─", "│", "─", "│", "╭", "╮", "╯", "╰"},
 		  color_devicons = true,
      use_less = true,
      set_env = {["COLORTERM"] = "truecolor"}, -- default = nil,
      file_previewer = require("telescope.previewers").vim_buffer_cat.new,
      grep_previewer = require("telescope.previewers").vim_buffer_vimgrep.new,
      qflist_previewer = require("telescope.previewers").vim_buffer_qflist.new,
      -- Developer configurations: Not meant for general override
      buffer_previewer_maker = require("telescope.previewers").buffer_previewer_maker
    },
}
EOF

lua << EOF
require("nvim-treesitter").setup {}
require("nvim-treesitter.configs").setup({
   ensure_installed = { "c", "lua", "vim", "vimdoc", "rust", "query", "elixir", "heex", "javascript", "html" },
   sync_install = true,
   highlight = { enable = true },
   indent = { enable = true },  
})
EOF

lua << EOF
require("action-hints").setup({
     template = {
        	definition = { text = " ⊛", color = "#add8e6" },
        	references = { text = " ↱%s", color = "#ff6666" },
     },
	  sections = {
    		lualine_x = { require("action-hints").statusline },
  	  },
     use_virtual_text = true,
})
EOF

lua << EOF
require("noice").setup({
lsp = {
    -- override markdown rendering so that **cmp** and other plugins use **Treesitter**
    override = {
      ["vim.lsp.util.convert_input_to_markdown_lines"] = true,
      ["vim.lsp.util.stylize_markdown"] = true,
      ["cmp.entry.get_documentation"] = true, -- requires hrsh7th/nvim-cmp
    },
  },
  markdown = {
  hover = {
      ["|(%S-)|"] = vim.cmd.help, -- vim help links
      ["%[.-%]%((%S-)%)"] = require("noice.util").open, -- markdown links
    },
    highlights = {
      ["|%S-|"] = "@text.reference",
      ["@%S+"] = "@parameter",
      ["^%s*(Parameters:)"] = "@text.title",
      ["^%s*(Return:)"] = "@text.title",
      ["^%s*(See also:)"] = "@text.title",
      ["{%S-}"] = "@parameter",
    },
  },
  health = {
    checker = true, -- Disable if you don't want health checks to run
  },
  -- you can enable a preset for easier configuration
  presets = {
    bottom_search = true, -- use a classic bottom cmdline for search
    command_palette = true, -- position the cmdline and popupmenu together
    long_message_to_split = true, -- long messages will be sent to a split
    inc_rename = false, -- enables an input dialog for inc-rename.nvim
    lsp_doc_border = false, -- add a border to hover docs and signature help
  },
})
EOF

lua << EOF 
vim.fn.sign_define("DiagnosticSignError", { text = " ", texthl = "DiagnosticSignError" })
vim.fn.sign_define("DiagnosticSignWarn", { text = " ", texthl = "DiagnosticSignWarn" })
vim.fn.sign_define("DiagnosticSignInfo", { text = " ", texthl = "DiagnosticSignInfo" }) 
vim.fn.sign_define("DiagnosticSignHint", { text = "󰌵", texthl = "DiagnosticSignHint" })
EOF

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
require('neogit').setup {
 -- Hides the hints at the top of the status buffer
  disable_hint = false,
  -- Disables changing the buffer highlights based on where the cursor is.
  disable_context_highlighting = false,
  -- Disables signs for sections/items/hunks
  disable_signs = false,
  -- Changes what mode the Commit Editor starts in. `true` will leave nvim in normal mode, `false` will change nvim to
  -- insert mode, and `"auto"` will change nvim to insert mode IF the commit message is empty, otherwise leaving it in
  -- normal mode.
  disable_insert_on_commit = "auto",
  -- When enabled, will watch the `.git/` directory for changes and refresh the status buffer in response to filesystem
  -- events.
  filewatcher = {
    interval = 1000,
    enabled = true,
  },
  -- "ascii"   is the graph the git CLI generates
  -- "unicode" is the graph like https://github.com/rbong/vim-flog
  graph_style = "ascii",
  -- Used to generate URL's for branch popup action "pull request".
  git_services = {
    ["github.com"] = "https://github.com/${owner}/${repository}/compare/${branch_name}?expand=1",
    ["bitbucket.org"] = "https://bitbucket.org/${owner}/${repository}/pull-requests/new?source=${branch_name}&t=1",
    ["gitlab.com"] = "https://gitlab.com/${owner}/${repository}/merge_requests/new?merge_request[source_branch]=${branch_name}",
  },
  -- Allows a different telescope sorter. Defaults to 'fuzzy_with_index_bias'. The example below will use the native fzf
  -- sorter instead. By default, this function returns `nil`.
  telescope_sorter = function()
    return require("telescope").extensions.fzf.native_fzf_sorter()
  end,
  -- Persist the values of switches/options within and across sessions
  remember_settings = true,
  -- Scope persisted settings on a per-project basis
  use_per_project_settings = true,
  -- Table of settings to never persist. Uses format "Filetype--cli-value"
  ignored_settings = {
    "NeogitPushPopup--force-with-lease",
    "NeogitPushPopup--force",
    "NeogitPullPopup--rebase",
    "NeogitCommitPopup--allow-empty",
    "NeogitRevertPopup--no-edit",
  },
  -- Configure highlight group features
  highlight = {
    italic = true,
    bold = true,
    underline = true
  },
  -- Set to false if you want to be responsible for creating _ALL_ keymappings
  use_default_keymaps = true,
  -- Neogit refreshes its internal state after specific events, which can be expensive depending on the repository size.
  -- Disabling `auto_refresh` will make it so you have to manually refresh the status after you open it.
  auto_refresh = true,
  -- Value used for `--sort` option for `git branch` command
  -- By default, branches will be sorted by commit date descending
  -- Flag description: https://git-scm.com/docs/git-branch#Documentation/git-branch.txt---sortltkeygt
  -- Sorting keys: https://git-scm.com/docs/git-for-each-ref#_options
  sort_branches = "-committerdate",
  -- Change the default way of opening neogit
  kind = "tab",
  -- Disable line numbers and relative line numbers
  disable_line_numbers = true,
  -- The time after which an output console is shown for slow running commands
  console_timeout = 2000,
  -- Automatically show console if a command takes more than console_timeout milliseconds
  auto_show_console = true,
  -- Automatically close the console if the process exits with a 0 (success) status
  auto_close_console = true,
  status = {
    show_head_commit_hash = true,
    recent_commit_count = 10,
    HEAD_padding = 10,
    HEAD_folded = false,
    mode_padding = 3,
    mode_text = {
      M = "modified",
      N = "new file",
      A = "added",
      D = "deleted",
      C = "copied",
      U = "updated",
      R = "renamed",
      DD = "unmerged",
      AU = "unmerged",
      UD = "unmerged",
      UA = "unmerged",
      DU = "unmerged",
      AA = "unmerged",
      UU = "unmerged",
      ["?"] = "",
    },
  },
  commit_editor = {
    kind = "tab",
    show_staged_diff = true,
    -- Accepted values:
    -- "split" to show the staged diff below the commit editor
    -- "vsplit" to show it to the right
    -- "split_above" Like :top split
    -- "vsplit_left" like :vsplit, but open to the left
    -- "auto" "vsplit" if window would have 80 cols, otherwise "split"
    staged_diff_split_kind = "split"
  },
  commit_select_view = {
    kind = "tab",
  },
  commit_view = {
    kind = "vsplit",
    verify_commit = vim.fn.executable("gpg") == 1, -- Can be set to true or false, otherwise we try to find the binary
  },
  log_view = {
    kind = "tab",
  },
  rebase_editor = {
    kind = "auto",
  },
  reflog_view = {
    kind = "tab",
  },
  merge_editor = {
    kind = "auto",
  },
  tag_editor = {
    kind = "auto",
  },
  preview_buffer = {
    kind = "split",
  },
  popup = {
    kind = "split",
  },
  signs = {
    -- { CLOSED, OPENED }
    hunk = { "", "" },
    item = { ">", "v" },
    section = { ">", "v" },
  },
  -- Each Integration is auto-detected through plugin presence, however, it can be disabled by setting to `false`
  integrations = {
    -- If enabled, use telescope for menu selection rather than vim.ui.select.
    -- Allows multi-select and some things that vim.ui.select doesn't.
    telescope =true,
    -- Neogit only provides inline diffs. If you want a more traditional way to look at diffs, you can use `diffview`.
    -- The diffview integration enables the diff popup.
    --
    -- Requires you to have `sindrets/diffview.nvim` installed.
    diffview = true,

    -- If enabled, uses fzf-lua for menu selection. If the telescope integration
    -- is also selected then telescope is used instead
    -- Requires you to have `ibhagwan/fzf-lua` installed.
    fzf_lua = nil,
  },
  sections = {
    -- Reverting/Cherry Picking
    sequencer = {
      folded = false,
      hidden = false,
    },
    untracked = {
      folded = false,
      hidden = false,
    },
    unstaged = {
      folded = false,
      hidden = false,
    },
    staged = {
      folded = false,
      hidden = false,
    },
    stashes = {
      folded = true,
      hidden = false,
    },
    unpulled_upstream = {
      folded = true,
      hidden = false,
    },
    unmerged_upstream = {
      folded = false,
      hidden = false,
    },
    unpulled_pushRemote = {
      folded = true,
      hidden = false,
    },
    unmerged_pushRemote = {
      folded = false,
      hidden = false,
    },
    recent = {
      folded = true,
      hidden = false,
    },
    rebase = {
      folded = true,
      hidden = false,
    },
  },
  mappings = {
    commit_editor = {
      ["q"] = "Close",
      ["<c-c><c-c>"] = "Submit",
      ["<c-c><c-k>"] = "Abort",
    },
    commit_editor_I = {
      ["<c-c><c-c>"] = "Submit",
      ["<c-c><c-k>"] = "Abort",
    },
    rebase_editor = {
      ["p"] = "Pick",
      ["r"] = "Reword",
      ["e"] = "Edit",
      ["s"] = "Squash",
      ["f"] = "Fixup",
      ["x"] = "Execute",
      ["d"] = "Drop",
      ["b"] = "Break",
      ["q"] = "Close",
      ["<cr>"] = "OpenCommit",
      ["gk"] = "MoveUp",
      ["gj"] = "MoveDown",
      ["<c-c><c-c>"] = "Submit",
      ["<c-c><c-k>"] = "Abort",
      ["[c"] = "OpenOrScrollUp",
      ["]c"] = "OpenOrScrollDown",
    },
    rebase_editor_I = {
      ["<c-c><c-c>"] = "Submit",
      ["<c-c><c-k>"] = "Abort",
    },
    finder = {
      ["<cr>"] = "Select",
      ["<c-c>"] = "Close",
      ["<esc>"] = "Close",
      ["<up>"] = "Previous",
      ["<down>"] = "Next",
      ["<tab>"] = "MultiselectToggleNext",
      ["<s-tab>"] = "MultiselectTogglePrevious",
      ["<c-j>"] = "NOP",
    },
    -- Setting any of these to `false` will disable the mapping.
    popup = {
      ["?"] = "HelpPopup",
      ["A"] = "CherryPickPopup",
      ["D"] = "DiffPopup",
      ["M"] = "RemotePopup",
      ["P"] = "PushPopup",
      ["X"] = "ResetPopup",
      ["Z"] = "StashPopup",
      ["b"] = "BranchPopup",
      ["B"] = "BisectPopup",
      ["c"] = "CommitPopup",
      ["f"] = "FetchPopup",
      ["l"] = "LogPopup",
      ["m"] = "MergePopup",
      ["p"] = "PullPopup",
      ["r"] = "RebasePopup",
      ["v"] = "RevertPopup",
      ["w"] = "WorktreePopup",
    },
    status = {
      ["k"] = "MoveUp",
      ["j"] = "MoveDown",
      ["q"] = "Close",
      ["o"] = "OpenTree",
      ["I"] = "InitRepo",
      ["1"] = "Depth1",
      ["2"] = "Depth2",
      ["3"] = "Depth3",
      ["4"] = "Depth4",
      ["<tab>"] = "Toggle",
      ["x"] = "Discard",
      ["s"] = "Stage",
      ["S"] = "StageUnstaged",
      ["<c-s>"] = "StageAll",
      ["K"] = "Untrack",
      ["u"] = "Unstage",
      ["U"] = "UnstageStaged",
      ["$"] = "CommandHistory",
      ["Y"] = "YankSelected",
      ["<c-r>"] = "RefreshBuffer",
      ["<enter>"] = "GoToFile",
      ["<c-v>"] = "VSplitOpen",
      ["<c-x>"] = "SplitOpen",
      ["<c-t>"] = "TabOpen",
      ["{"] = "GoToPreviousHunkHeader",
      ["}"] = "GoToNextHunkHeader",
      ["[c"] = "OpenOrScrollUp",
      ["]c"] = "OpenOrScrollDown",
    },
  },
}
EOF
lua require("mini.cursorword").setup()
lua require("toggleterm").setup {}
lua << EOF
require("toggleterm").setup({
   hide_numbers = true, -- hide the number column in toggleterm buffers
   autochdir = false,
   start_in_insert = true,
   insert_mappings = true, -- whether or not the open mapping applies in insert mode
   terminal_mappings = true, -- whether or not the open mapping applies in the opened terminals
   persist_size = true,
   persist_mode = true, -- if set to true (default) the previous terminal mode will be remembered
   close_on_exit = true, -- close the terminal window when the process exits
  -- shell = vim.o.shell
   auto_scroll = true, -- automatically scroll to the bottom on terminal output
   float_opts = {
      border = 'single', 
      title_pos = 'left', 
   },
})
EOF


lua << EOF
require("neo-tree").setup({
    	  close_if_last_window = true, -- Close Neo-tree if it is the last window left in the tab
        popup_border_style = "rounded",
        enable_git_status = true,
        enable_diagnostics = true,
        open_files_do_not_replace_types = { "terminal", "trouble", "qf" }, -- when opening files, do not use windows containing these filetypes or buftypes
        sort_case_insensitive = true, -- used when sorting files and directories in the tree
        sort_function = nil , -- use a custom function for sorting files and directories in the tree 
        default_component_configs = {
          container = {
            enable_character_fade = true
          },
          indent = {
            indent_size = 2,
            padding = 1, -- extra padding on left hand side
            with_markers = true,
            indent_marker = "│",
            last_indent_marker = "└",
            highlight = "NeoTreeIndentMarker",
            with_expanders = nil, -- if nil and file nesting is enabled, will enable expanders
            expander_collapsed = "",
            expander_expanded = "",
            expander_highlight = "NeoTreeExpander",
          },
          icon = {
            folder_closed = "",
            folder_open = "",
            folder_empty = "󰜌",
            -- The next two settings are only a fallback, if you use nvim-web-devicons and configure default icons there
            -- then these will never be used.
            default = "*",
            highlight = "NeoTreeFileIcon"
          },
          modified = {
            symbol = "[+]",
            highlight = "NeoTreeModified",
          },
          name = {
            trailing_slash = true,
            use_git_status_colors = true,
            highlight = "NeoTreeFileName",
          },
          git_status = {
            symbols = {
              -- Change type
              added     = "✚", -- or "✚", but this is redundant info if you use git_status_colors on the name
              modified  = "", -- or "", but this is redundant info if you use git_status_colors on the name
              deleted   = "✖",-- this can only be used in the git_status source
              renamed   = "󰁕",-- this can only be used in the git_status source
              -- Status type
              untracked = "",
              ignored   = "",
              unstaged  = "󰄱",
              staged    = "",
              conflict  = "",
            }
          },
          -- If you don't want to use these columns, you can set `enabled = false` for each of them individually
          file_size = {
            enabled = true,
            required_width = 64, -- min width of window required to show this column
          },
          type = {
            enabled = true,
            required_width = 122, -- min width of window required to show this column
          },
          last_modified = {
            enabled = true,
            required_width = 88, -- min width of window required to show this column
          },
          created = {
            enabled = true,
            required_width = 110, -- min width of window required to show this column
          },
          symlink_target = {
            enabled = false,
          },
        },
        -- A list of functions, each representing a global custom command
        -- that will be available in all sources (if not overridden in `opts[source_name].commands`)
        -- see `:h neo-tree-custom-commands-global`
        commands = {},
        window = {
          position = "left",
          width = 30,
          mapping_options = {
            noremap = true,
            nowait = true,
          },
          mappings = {
           ["P"] = { "toggle_preview", config = { use_float = true, use_image_nvim = true } },
            ["l"] = "focus_preview",
            ["S"] = "open_split",
            ["s"] = "open_vsplit",
            ["t"] = "open_tabnew",
            ["w"] = "open_with_window_picker",
            ["C"] = "close_node",
            ["z"] = "close_all_nodes",
            ["a"] = { 
              "add",
              config = {
                show_path = "none" -- "none", "relative", "absolute"
              }
            },
            ["A"] = "add_directory", -- also accepts the optional config.show_path option like "add". this also supports BASH style brace expansion.
            ["<del>"] = "delete",
            ["re"] = "rename",
            ["y"] = "copy_to_clipboard",
            ["x"] = "cut_to_clipboard",
            ["p"] = "paste_from_clipboard",
            ["c"] = "copy", -- takes text input for destination, also accepts the optional config.show_path option like "add":
            ["m"] = "move", -- takes text input for destination, also accepts the optional config.show_path option like "add".
            ["q"] = "close_window",
            ["R"] = "refresh",
            ["?"] = "show_help",
            ["<"] = "prev_source",
            [">"] = "next_source",
            ["i"] = "show_file_details",
          }
        },
        nesting_rules = {},
        filesystem = {
          filtered_items = {
            visible = true, -- when true, they will just be displayed differently than normal items
            hide_dotfiles = true,
            hide_gitignored = true,
            hide_hidden = true, -- only works on Windows for hidden files/directories
          },
          follow_current_file = {
            enabled = true, -- This will find and focus the file in the active buffer every time
            --               -- the current file is changed while the tree is open.
            leave_dirs_open = false, -- `false` closes auto expanded dirs, such as with `:Neotree reveal`
          },
          group_empty_dirs = false, -- when true, empty folders will be grouped together
          hijack_netrw_behavior = "open_current", -- netrw disabled, opening a directory opens neo-tree
                                                  -- in whatever position is specified in window.position
                                -- "open_default",  -- netrw disabled, opening a directory opens within the
                                                  -- window like netrw would, regardless of window.position
                                -- "disabled",    -- netrw left alone, neo-tree does not handle opening dirs
          use_libuv_file_watcher = true, -- This will use the OS level file watchers to detect changes
          window = {
            mappings = {
              ["<bs>"] = "navigate_up",
              ["."] = "set_root",
              ["f"] = "filter_on_submit",
              ["[g"] = "prev_git_modified",
              ["]g"] = "next_git_modified",
              ["o"] = { "show_help", nowait=false, config = { title = "Order by", prefix_key = "o" }},
            },
          },

          commands = {} -- Add a custom command or override a global one using the same function name
        },
        buffers = {
          follow_current_file = {
            enabled = true, -- This will find and focus the file in the active buffer every time
            --              -- the current file is changed while the tree is open.
            leave_dirs_open = false, -- `false` closes auto expanded dirs, such as with `:Neotree reveal`
          },
          group_empty_dirs = true, -- when true, empty folders will be grouped together
          show_unloaded = true,
          window = {
            mappings = {
              ["bd"] = "buffer_delete",
              ["."] = "set_root",
              ["oc"] = { "order_by_created", nowait = false },
              ["od"] = { "order_by_diagnostics", nowait = false },
              ["om"] = { "order_by_modified", nowait = false },
              ["on"] = { "order_by_name", nowait = false },
              ["os"] = { "order_by_size", nowait = false },
              ["ot"] = { "order_by_type", nowait = false },
            }
          },
        },
        git_status = {
          window = {
            position = "float",
            mappings = {
              ["A"]  = "git_add_all",
              ["gu"] = "git_unstage_file",
              ["ga"] = "git_add_file",
              ["gr"] = "git_revert_file",
              ["gc"] = "git_commit",
              ["gp"] = "git_push",
              ["gg"] = "git_commit_and_push",
              ["o"] = { "show_help", nowait=false, config = { title = "Order by", prefix_key = "o" }},
              ["oc"] = { "order_by_created", nowait = false },
              ["od"] = { "order_by_diagnostics", nowait = false },
              ["om"] = { "order_by_modified", nowait = false },
              ["on"] = { "order_by_name", nowait = false },
              ["os"] = { "order_by_size", nowait = false },
              ["ot"] = { "order_by_type", nowait = false },
            }
          }
        },
   source_selector = {
            winbar = true,
            statusline = true, 
  },
})
EOF

lua << EOF
  require('barbar').setup {
     animation = true,
     insert_at_start = true,
     cons = {
    -- Configure the base icons on the bufferline.
    -- Valid options to display the buffer index and -number are `true`, 'superscript' and 'subscript'
    buffer_index = false,
    buffer_number = false,
    button = '',
    -- Enables / disables diagnostic symbols
    diagnostics = {
      [vim.diagnostic.severity.ERROR] = {enabled = true, icon = 'ﬀ'},
      [vim.diagnostic.severity.WARN] = {enabled = true},
      [vim.diagnostic.severity.INFO] = {enabled = true},
      [vim.diagnostic.severity.HINT] = {enabled = true},
    },
    gitsigns = {
      added = {enabled = true, icon = '+'},
      changed = {enabled = true, icon = '•'},
      deleted = {enabled = true, icon = 'x'},
    },
    filetype = {
      -- Sets the icon's highlight group.
      -- If false, will use nvim-web-devicons colors
      custom_colors = false,

      -- Requires `nvim-web-devicons` if `true`
      enabled = true,
    },
    separator = {left = '▎', right = ''},

    -- If true, add an additional separator at the end of the buffer list
    separator_at_end = true,

    -- Configure the icons on the bufferline when modified or pinned.
    -- Supports all the base icon options.
    modified = {button = '●'},
    pinned = {button = '', filename = true},

    -- Use a preconfigured buffer appearance— can be 'default', 'powerline', or 'slanted'
    preset = 'default',

    -- Configure the icons on the bufferline based on the visibility of a buffer.
    -- Supports all the base icon options, plus `modified` and `pinned`.
    alternate = {filetype = {enabled = false}},
    current = {buffer_index = true},
    inactive = {button = '×'},
    visible = {modified = {buffer_number = false}},
  },

  -- If true, new buffers will be inserted at the start/end of the list.
  -- Default is to insert after current buffer.
  insert_at_end = false,
  insert_at_start = false,

  -- Sets the maximum padding width with which to surround each tab
  maximum_padding = 1,

  -- Sets the minimum padding width with which to surround each tab
  minimum_padding = 1,

  -- Sets the maximum buffer name length.
  maximum_length = 30,

  -- Sets the minimum buffer name length.
  minimum_length = 0,

  -- If set, the letters for each buffer in buffer-pick mode will be
  -- assigned based on their name. Otherwise or in case all letters are
  -- already assigned, the behavior is to assign letters in order of
  -- usability (see order below)
  semantic_letters = true,

  -- Set the filetypes which barbar will offset itself for
  sidebar_filetypes = {
    -- Use the default values: {event = 'BufWinLeave', text = '', align = 'left'}
    NvimTree = true,
    -- Or, specify the text used for the offset:
    undotree = {
      text = 'undotree',
      align = 'center', -- *optionally* specify an alignment (either 'left', 'center', or 'right')
    },
    -- Or, specify the event which the sidebar executes when leaving:
    ['neo-tree'] = {event = 'BufWipeout'},
    -- Or, specify all three
    Outline = {event = 'BufWinLeave', text = 'symbols-outline', align = 'right'},
  },

  -- New buffer letters are assigned in this order. This order is
  -- optimal for the qwerty keyboard layout but might need adjustment
  -- for other layouts.
  letters = 'asdfjkl;ghnmxcvbziowerutyqpASDFJKLGHNMXCVBZIOWERUTYQP',

  -- Sets the name of unnamed buffers. By default format is "[Buffer X]"
  -- where X is the buffer number. But only a static string is accepted here.
  no_name_title = nil,
  version = '^1.0.0', -- optional: only update when a new 1.x version is released
}
EOF

lua << EOF
require("lspconfig").dartls.setup({lazy = true})
local cmp = require('cmp')
local luasnip = require("luasnip")
local lspkind = require("lspkind")
luasnip.filetype_extend("flutter", { "dart" })
require("luasnip.loaders.from_vscode").lazy_load( {
  '~/.vscode/extensions/nash.awesome-flutter-snippets-4.0.1/snippets',
})
cmp.setup({
event = {"InsertEnter", "CmdlineEnter"},
snippet = {
      expand = function(args)
        luasnip.lsp_expand(args.body) -- For `luasnip` users.
        -- vim.snippet.expand(args.body) -- For native neovim snippets (Neovim v0.10+)
      end,
    },
	 completion = { completeopt = "menu,menuone,noselect" },
	 mapping = { 
    		['<C-b>'] = cmp.mapping.scroll_docs(-4),
    	  ['<C-f>'] = cmp.mapping.scroll_docs(4),
        ['<C-space>'] = cmp.mapping.complete(),
				['<C-e>'] = cmp.mapping.abort(),
    	--['<TAB>'] = cmp.mapping.confirm {
      --		behavior = cmp.ConfirmBehavior.Insert,
      --		select = true,
    	--	},	
        ['<CR>'] = cmp.mapping.confirm {
      		behavior = cmp.ConfirmBehavior.Insert,
      		select = true,
    		},	
    		['<C-n>'] = cmp.mapping.select_next_item(), 
    		['<down>'] = cmp.mapping.select_next_item(), 
    		['<C-p>'] = cmp.mapping.select_prev_item(), 
    		['<up>'] = cmp.mapping.select_prev_item(), 
    },
    -- sources for autocompletion
				sources = {
						{ name = 'nvim_lsp' },
      		  { name = 'luasnip' }, -- For luasnip users.
						{ name = "buffer"},
						{ name = "path" },
				},
				-- Enable pictogram icons for lsp/autocompletion
				formatting = {
					expandable_indicator = false,
					format = lspkind.cmp_format({
						mode = "symbol_text",
						maxwidth = 50,
						ellipsis_char = "...",
						symbol_map = {
							Copilot = "",
						},
					}),
				},
				experimental = {
					ghost_text = false,
				},

  })
cmp.setup.filetype('gitcommit', {
    sources = cmp.config.sources({
      { name = 'git' },
    }, {
      { name = 'buffer' },
    })
 })
 require("cmp_git").setup() 

  -- Use buffer source for `/` and `?` (if you enabled `native_menu`, this won't work anymore).
  cmp.setup.cmdline({ '/', '?' }, {
    mapping = cmp.mapping.preset.cmdline(),
	 sources = {
      { name = 'buffer' }
    }
  })

  -- Use cmdline & path source for ':' (if you enabled `native_menu`, this won't work anymore).
  cmp.setup.cmdline(':', {
    mapping = cmp.mapping.preset.cmdline(),
    sources = cmp.config.sources({
      { name = 'path' }
    }, {
      { name = 'cmdline' }
    }),
    matching = { disallow_symbol_nonprefix_matching = false }
  })
--While we using Flutter-tools, this must be deactivate 
local capabilities = require('cmp_nvim_lsp').default_capabilities()
require('lspconfig')['dartls'].setup {
    	capabilities = capabilities
}

EOF

" Custom Dart and Flutter snippets
lua << EOF
local ls = require('luasnip')
local s = ls.snippet
local t = ls.text_node
local i = ls.insert_node
ls.add_snippets("dart", {
    s("mateapp", {
      t({"import 'package:flutter/material.dart';", "", "void main() => runApp(const MyApp());", "", "class MyApp extends StatelessWidget {", "  const MyApp({super.key});", "", "  @override", "  Widget build(BuildContext context) {", "    return MaterialApp(", "      title: 'Material App',", "      home: Scaffold(", "        appBar: AppBar(", "          title: const Text('Material App Bar'),", "        ),", "        body: const Center(", "          child: Text('Hello World'),", "        ),", "      ),", "    );", "  }", "}"})
    }),
})

ls.add_snippets("dart", {
    s("inheritedW", {
      t("class "), i(1, "Name"), t(" extends InheritedWidget {"),
      t({"", "  const "}), i(1, "Name"), t({"({super.key, required this.child}) : super(child: child);", "  final Widget child;", "", "  static "}), i(1, "Name"), t({"? of(BuildContext context) {", "    return context.dependOnInheritedWidgetOfExactType<"}), i(1, "Name"), t({">();", "  }", "", "  @override", "  bool updateShouldNotify("}), i(1, "Name"), t({ " oldWidget) {", "    return " }), i(2, "true"), t({ ";", "  }", "}" })
    }),
  })
ls.add_snippets('dart', {

    s("f-test", {
      t("test("), t({ '"Test",', "  () {", "", "  },", ");" })
    }),

  })

ls.add_snippets('dart', {
    s("valueListenable", {
      t("ValueListenableBuilder("),
      t("valueListenable: "), i(1, "null"), t(","),
      t({"", "builder: (BuildContext context, "}), i(2, "dynamic"), t(" value, Widget? child) {"),
      t({"", "  return "}), i(3, "Container()"), t({ ";", "}" })
    }),
  })

ls.add_snippets('dart', {
    s("reassemble", {
      t({"@override", "void reassemble(){", "  "}), i(0), t({"", "  super.reassemble();", "}"})
    }),
  })


ls.add_snippets('dart', {
    s("useEffect", {
      t("useEffect(() {"),
      t({"", "  "}), i(0), t({"", "  return null;", "}, <Object?>[]);"})
    }),
  })

ls.add_snippets('dart', {
    s("init", {
      t({"@override", "void initState(){", "  super.initState();", "}"})
    }),
  })

ls.add_snippets('dart', {
    s("dis", {
      t({"@override", "void dispose(){", "  "}), i(0), t({"", "  super.dispose();", "}"})
    }),
})

ls.add_snippets('dart', {
    s("didC", {
      t({"@override", "void didChangeDependencies() {", "  "}), i(0), t({"", "  super.didChangeDependencies();", "}"})
    }),
})

ls.add_snippets('dart', {
    s("statefulW", {
      t("class "), i(1, "ClassName"), t(" extends StatefulWidget {"),
      t({"", "  const "}), i(1, "ClassName"), t({ "({super.key});", "", "  @override", "  State<"}), i(1, "ClassName"), t("> createState() => _"), i(1, "ClassName"), t({"State();", "}", "class _"}), i(1, "ClassName"), t("State extends State<"), i(1, "ClassName"), t({"> {", "", "  @override", "  Widget build(BuildContext context) {", "    return Container();", "  }", "}"})
    }),
  })

ls.add_snippets('dart', {
    s("statelessW", {
      t("class "), i(1, "ClassName"), t(" extends StatelessWidget {"),
      t({"", "  const "}), i(1, "ClassName"), t({ "({super.key});", "", "  @override", "  Widget build(BuildContext context) {", "    return Container();", "  }", "}"})
    }),
  })

ls.add_snippets('dart', {
    s("equatable", {
      t("import 'package:equatable/equatable.dart';")
    }),
  })

ls.add_snippets('dart', {
  s("equaclass", {
  t("import 'package:equatable/equatable.dart';"),
  t({"", "", "class "}), i(1, "ClassName"), t(" extends Equatable {"),
  t({"", "  final "}), i(2, "propertyType"), t(" "), i(3, "propertyName"), t(";"),
  t({"", "", "  const "}), i(1, "ClassName"), t({ "({required this."}), i(3, "propertyName"), t({"});", "", "  @override", "  List<Object?> get props => ["}), i(3, "propertyName"), t({"];", "}"})
  })
})

ls.add_snippets('dart', {
  s("nbloc", {
    t("import 'dart:async';"),
    t({"", "abstract class "}), i(1, "MyEvent"), t(" {}"),
    t({"", "", "class "}), i(2, "MyState"), t(" {"),
    t({"", "  const "}), i(2, "MyState"), t({"();", "}", "", "class "}), i(3, "MyBloc"), t({" {", "  final _stateController = StreamController<"}), i(2, "MyState"), t({">();", "", "  Stream<"}), i(2, "MyState"), t({"> get state => _stateController.stream;", "", "  final _eventController = StreamController<"}), i(1, "MyEvent"), t({">();", "", "  Sink<"}), i(1, "MyEvent"), t({"> get eventSink => _eventController.sink;", "", "  "}), i(3, "MyBloc"), t({"() {", "    _eventController.stream.listen(_mapEventToState);", "  }", "", "  void _mapEventToState("}), i(1, "MyEvent"), t(" event) {"),
    t({"", "    // TODO: Add Logic", "    // Example:", "    // if (event is MySpecificEvent) {", "    //   _stateController.sink.add(MySpecificState());", "    // }", "  }", "", "  void dispose() {", "    _stateController.close();", "    _eventController.close();", "  }", "}"}),
    t({"", "", "class "}), i(4, "MySpecificEvent"), t(" extends "), i(1, "MyEvent"), t(" {}"),
    t({"", "", "class "}), i(5, "MySpecificState"), t(" extends "), i(2, "MyState"), t(" {"),
    t({"", "  const "}), i(5, "MySpecificState"), t("();", "}")
  }),
})

ls.add_snippets('dart', {
  s("bloc", {
      -- Import statements
      t("import 'package:flutter_bloc/flutter_bloc.dart';"),
      t({"", "import 'package:equatable/equatable.dart';", "", "part '"}), i(1, "my_bloc"), t({"_event.dart';", "part '"}), i(1, "my_bloc"), t({"_state.dart';", "", ""}),
    -- BLoC class
      t("class "), i(2, "MyBloc"), t(" extends Bloc<"), i(3, "MyEvent"), t(", "), i(4, "MyState"), t("> {"),
      t({"", "  "}), i(2, "MyBloc"), t({"() : super("}), i(4, "MyInitialState"), t({"());", "", "  @override", "  Stream<"}), i(4, "MyState"), t("> mapEventToState("), i(3, "MyEvent"), t(" event) async* {"),
      t({"", "    // TODO: Add Logic", "    // Example:", "    // if (event is MySpecificEvent) {", "    //   yield MySpecificState();", "    // }", "  }", "}", "", ""}),
      -- Event class
      t("abstract class "), i(3, "MyEvent"), t(" extends Equatable {"),
      t({"", "  const "}), i(3, "MyEvent"), t({";", "", "  @override", "  List<Object> get props => [];", "}", "", ""}),
      -- State class
      t("abstract class "), i(4, "MyState"), t(" extends Equatable {"),
      t({"", "  const "}), i(4, "MyState"), t({";", "", "  @override", "  List<Object> get props => [];", "}", "", ""}),
      -- Initial State class
      t("class "), i(4, "MyInitialState"), t(" extends "), i(4, "MyState"), t(" {"),
      t({"", "  const "}), i(4, "MyInitialState"), t({"();", "}"})
  })
})
EOF

lua << EOF 
require("gruvbox").setup({
  terminal_colors = true, 
  undercurl = true,
  underline = true,
  bold = true,
  italic = {
    strings = true,
    emphasis = true,
    comments = true,
    operators = false,
    folds = true,
  },
  strikethrough = true,
  invert_selection = false,
  invert_signs = false,
  invert_tabline = false,
  invert_intend_guides = false,
  inverse = true, -- invert background for search, diffs, statuslines and errors
  contrast = "", -- can be "hard", "soft" or empty string
  palette_overrides = {},
  overrides = {},
  dim_inactive = false,
  transparent_mode = true,
})
EOF

lua << EOF
require("notify").setup({
	fps = 60, 
	render = "compact", 
	stages = "slide", 
	stages = 'fade_in_slide_out',
	background_colour = 'FloatShadow',
	timeout = 3000,
	top_down = false,
})
EOF

lua << EOF
require("flutter-tools").setup {
  lineLength = 120,
  debugger = { -- integrate with nvim dap + install dart code debugger
    enabled = true,
	 	exception_breakpoints = nil,
  },
  ui = {
    border = "rounded",
    notification_style = 'native'
  },
  decorations = {
    statusline = {
      app_version = true,
      device = true,
      project_config = false,
    }
  },
  flutter_path = "/home/cathood/development/flutter/bin/flutter", -- <-- this takes priority over the lookup
  root_patterns = { ".git", "pubspec.yaml" }, -- patterns to find the root of your flutter project
  widget_guides = {
    enabled = true,
  },
  closing_tags = {
    highlight = "Comment",
    prefix = "// ",
    enabled = true,
	},	
	dev_log = {
    enabled = true,
    notify_errors = true, -- if there is an error whilst running then notify the user
  },
  dev_tools = {
    autostart = false, -- autostart devtools server if not detected
    auto_open_browser = false, -- Automatically opens devtools in the browser
  },
  lsp = {
        capabilities = function(config)
            config.textDocument.codeAction = {
                dynamicRegistration = false,
                codeActionLiteralSupport = {
                    codeActionKind = {
                        valueSet = {
                            "quickfix",
                            "refactor",
                            "refactor.extract",
                            "refactor.inline",
                            "refactor.rewrite",
                            "source",
                            "source.organizeImports",
                        },
                    },
                },
            }

            return config
        end,
    color = { -- show the derived colours for dart variables
      enabled = false, -- whether or not to highlight color variables at all, only supported on flutter >= 2.10
      background = false, -- highlight the background
      background_color = nil, -- required, when background is transparent (i.e. background_color = { r = 19, g = 17, b = 24},)
      foreground = false, -- highlight the foreground
      virtual_text = true, -- show the highlight using virtual text
      virtual_text_str = "■", -- the virtual text character to highlight
    },
    settings = {
      showTodos = false,
      completeFunctionCalls = true,
      analysisExcludedFolders = {"~/development/flutter/packages/"},
      renameFilesWithClasses = "always", -- "always"
      enableSnippets = true,
      updateImportsOnRename = true, -- Whether to update imports and other directives when files are renamed. Required for `FlutterRename` command.
    }
    
    }
  }
EOF

lua << EOF
local opts = {
  log_level = 'info',
  auto_session_enable_last_session = vim.loop.cwd() == vim.loop.os_homedir(),
  auto_session_root_dir = vim.fn.stdpath('data').."/sessions/",
  auto_session_enabled = true,
  auto_save_enabled = true,
  auto_restore_enabled = true,
  auto_session_suppress_dirs = nil,
  auto_session_use_git_branch = true,
}

require('auto-session').setup(opts)
EOF

lua require('ibl').setup()
