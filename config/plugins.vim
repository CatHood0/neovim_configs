call plug#begin()
" Vim test
Plug 'vim-test/vim-test'
" Translator
Plug 'uga-rosa/translate.nvim'
" Auto sessions manager
Plug 'rmagatti/auto-session'
" Snippets
Plug 'SirVer/Ultisnips'
Plug 'natebosch/dartlang-snippets'
"Plug 'honza/vim-snippets'
" LSP tools preconfigured
Plug 'neoclide/coc.nvim', { 'branch': 'release'}
Plug 'mrbjarksen/neo-tree-diagnostics.nvim', { 'module' : 'neo-tree.sources.diagnostics' } " if wanting to lazyload
Plug 'nvim-lua/plenary.nvim'
Plug 'stevearc/dressing.nvim' 
" cmdline autocomplete (since the coc.nvim doesnt have support for cmdline autocompletion then this at least implement
" an alternative)
Plug 'hrsh7th/nvim-cmp'
Plug 'hrsh7th/cmp-cmdline'
Plug 'hrsh7th/cmp-path'
" IA Asistant 
Plug 'codota/tabnine-nvim', { 'do': './dl_binaries.sh' }
" Debugger
Plug 'mfussenegger/nvim-dap' 
" File explorer
Plug 'nvim-neo-tree/neo-tree.nvim'
" Window Tabs 
Plug 'nvim-tree/nvim-web-devicons' 
" Git 
Plug 'lewis6991/gitsigns.nvim' 
" Tabs
Plug 'romgrk/barbar.nvim'
"Plug 'akinsho/bufferline.nvim' 
" Windows picker manager
Plug 's1n7ax/nvim-window-picker', { 'version' : '2.*' }  
Plug 'tpope/vim-sensible'
" Custom status line
Plug 'nvim-lualine/lualine.nvim'
" Notifications
Plug 'rcarriga/nvim-notify'
Plug 'folke/noice.nvim'
" Code Formatter
Plug 'nvimtools/none-ls.nvim'
Plug 'MunifTanjim/nui.nvim' 
" Indent line guides
Plug 'lukas-reineke/indent-blankline.nvim'
" Actions Hints
Plug 'roobert/action-hints.nvim'
" Line mover
Plug 'hinell/move.nvim'
" Underline border for current word at current cursor position
Plug 'echasnovski/mini.cursorword', { 'branch': 'stable' }
" Log coloring - SEE IF HELPFUL
Plug 'mtdl9/vim-log-highlighting'
" Telescope (files finder, line finder, notifier, etc)
Plug 'nvim-telescope/telescope.nvim', { 'tag': '0.1.8' }
" Visual git manager
Plug 'NeogitOrg/neogit'
" Diff view for git
Plug 'sindrets/diffview.nvim'
Plug 'nvim-tree/nvim-web-devicons' " Recommended (for coloured icons)
" Open and close brackets automatically
"Plug 'jiangmiao/auto-pairs'
Plug 'altermo/ultimate-autopair.nvim'
" Help with surrounding stuff
"Plug 'tpope/vim-surround'
" Terminal
Plug 'akinsho/toggleterm.nvim', { 'tag' : '2.*'}
" FZf
Plug 'junegunn/fzf.vim'
Plug 'junegunn/fzf', { 'do': { -> fzf#install() } }
Plug 'BurntSushi/ripgrep'
" Multi cursor
Plug 'mg979/vim-visual-multi'
" Dashboard
Plug 'goolord/alpha-nvim'
" Styles for lua (still doesn't work)
Plug 'ckipp01/stylua-nvim', { 'run' : 'cargo install stylua' }
" Mason LSP,DAP,LINTER AND FORMATTER
Plug 'williamboman/mason.nvim' 
Plug 'williamboman/mason-lspconfig.nvim'
" Tree sitter
Plug 'nvim-treesitter/nvim-treesitter' 
" LSP manager timeout (avoid large size memory (Ram) consume)
Plug 'zeioth/garbage-day.nvim', { 'event' : 'VeryLazy' }
" Navigator 
Plug 'aserowy/tmux.nvim'
Plug 'akinsho/pubspec-assist.nvim'
" Adds information about what changed to the file at the place of line numbers
if has('nvim') || has('patch-8.0.902')
  Plug 'mhinz/vim-signify'
else
  Plug 'mhinz/vim-signify', { 'tag': 'legacy' }
endif
" Theme
Plug 'ellisonleao/gruvbox.nvim'
Plug 'rose-pine/neovim', { 'as' : 'rose-pine' }
Plug 'drewtempelmeyer/palenight.vim'
Plug 'navarasu/onedark.nvim'
Plug 'projekt0n/github-nvim-theme'
Plug 'rebelot/kanagawa.nvim'
" Color picker
Plug 'ziontee113/color-picker.nvim'
Plug 'MeanderingProgrammer/markdown.nvim'
Plug 'echasnovski/mini.nvim', { 'name' : 'render-markdown' }
call plug#end()
