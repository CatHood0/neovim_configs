call plug#begin()
" 1. CONFIGURACIÓN BÁSICA Y ESENCIALES
Plug 'tpope/vim-sensible'
Plug 'romgrk/barbar.nvim'          " Tabs (reemplazo de bufferline)
Plug 'stevearc/dressing.nvim'      " Mejoras UI para inputs y selects

" 2. INTERFAZ DE USUARIO Y TEMAS
" Temas visuales
Plug 'ellisonleao/gruvbox.nvim'
Plug 'rose-pine/neovim', { 'as': 'rose-pine' }
Plug 'drewtempelmeyer/palenight.vim'
Plug 'navarasu/onedark.nvim'
Plug 'projekt0n/github-nvim-theme'
Plug 'rebelot/kanagawa.nvim'
Plug 'srcery-colors/srcery-vim'
Plug 'catppuccin/nvim', { 'as': 'catppuccin' }

" Barra de estado y dashboard
Plug 'nvim-lualine/lualine.nvim'
Plug 'goolord/alpha-nvim'
Plug 'nvim-tree/nvim-web-devicons'  " Iconos

" 3. NAVEGACIÓN Y BUSQUEDA
" Explorador de archivos
Plug 'nvim-neo-tree/neo-tree.nvim'
Plug 'mrbjarksen/neo-tree-diagnostics.nvim'
Plug 'ryanoasis/vim-devicons' " Iconos

" Buscadores
Plug 'nvim-telescope/telescope.nvim', { 'tag': '0.1.8' }
Plug 'nvim-lua/plenary.nvim'        " Dependencia requerida
Plug 'junegunn/fzf.vim'
Plug 'junegunn/fzf', { 'do': { -> fzf#install() } }
Plug 'BurntSushi/ripgrep'

" Gestión de ventanas
Plug 's1n7ax/nvim-window-picker', { 'version': '2.*' }
Plug 'aserowy/tmux.nvim'            " Integración con tmux

" 4. LENGUAJE Y DESARROLLO
" LSP y autocompletado
Plug 'neoclide/coc.nvim', { 'branch': 'release' }
Plug 'williamboman/mason.nvim'
Plug 'williamboman/mason-lspconfig.nvim'
Plug 'hrsh7th/nvim-cmp'
Plug 'hrsh7th/cmp-cmdline'
Plug 'hrsh7th/cmp-path'
" Visualizador de problemas
Plug 'folke/trouble.nvim'

" Snippets
Plug 'SirVer/Ultisnips'
Plug 'natebosch/dartlang-snippets'
" Plug 'honza/vim-snippets'          (comentado originalmente)

" Debugging
Plug 'mfussenegger/nvim-dap'

" 5. CONTROL DE VERSIONES (GIT)
Plug 'tpope/vim-fugitive'
Plug 'lewis6991/gitsigns.nvim'
Plug 'sindrets/diffview.nvim'
Plug 'mhinz/vim-signify' 

" 6. EDICIÓN DE TEXTO Y CÓDIGO
" Pares y surrounds
Plug 'altermo/ultimate-autopair.nvim'
" Plug 'tpope/vim-surround'          (comentado originalmente)

" Indentación y sintaxis
Plug 'lukas-reineke/indent-blankline.nvim'
Plug 'HiPhish/rainbow-delimiters.nvim'
Plug 'nvim-treesitter/nvim-treesitter'
Plug 'mtdl9/vim-log-highlighting'

" Manipulación de texto
Plug 'hinell/move.nvim'             " Mover líneas
Plug 'mg979/vim-visual-multi'       " Multi-cursor

" Cursor y UI de edición
Plug 'echasnovski/mini.cursorword', { 'branch': 'stable' }
Plug 'sphamba/smear-cursor.nvim'

" 7. TERMINAL
Plug 'akinsho/toggleterm.nvim', { 'tag': '2.*' }

" 8. TESTING
Plug 'vim-test/vim-test'

" 9. UTILIDADES Y PRODUCTIVIDAD
" Sesiones y manejo de proyectos
Plug 'rmagatti/auto-session'

" Notificaciones y UI
Plug 'rcarriga/nvim-notify'
Plug 'folke/noice.nvim'

" Formateo y linting
Plug 'nvimtools/none-ls.nvim'
Plug 'MunifTanjim/nui.nvim'         " Dependencia UI
Plug 'ckipp01/stylua-nvim', { 'run': 'cargo install stylua' }

" Traducción
Plug 'uga-rosa/translate.nvim'

" Gestión de memoria
Plug 'zeioth/garbage-day.nvim', { 'event': 'VeryLazy' }

" 10. LENGUAJES ESPECÍFICOS
" Dart/Flutter
Plug 'akinsho/pubspec-assist.nvim'

" Markdown
Plug 'MeanderingProgrammer/markdown.nvim'
Plug 'echasnovski/mini.nvim', { 'name': 'render-markdown' }
Plug 'iamcco/markdown-preview.nvim', { 'do': 'cd app && npx --yes yarn install' }

" Color Picker
Plug 'ziontee113/color-picker.nvim'

" IA (comentado originalmente)
" Plug 'codota/tabnine-nvim', { 'do': './dl_binaries.sh' }

call plug#end()
