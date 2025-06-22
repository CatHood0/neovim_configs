" ==================== UI/Visual ====================
set number
set cursorline
set scrolloff=10
set showcmd
set showtabline=2                    " always show tabs
set colorcolumn=120
set textwidth=300
" set scrollbind     sync the scroll for all windows on vim 
set hlsearch
set pumheight=0
" set wrapmargin=10
" set showmatch
syntax on
set background=dark " or light if you want light mode
set laststatus=2
set signcolumn=yes

" ==================== Text/Editing ====================
set wrap
set expandtab
set autoindent
set nosmartindent                    " make indenting smarter again
set tabstop=2
set softtabstop=2
set shiftwidth=2
set backspace=indent,eol,start
set iskeyword+=-
" set paste
" Spelling correction
" set spell spelllang=en_us
filetype plugin indent on

" ==================== Search ====================
set ignorecase
set smartcase                        " smart case
set incsearch

" ==================== Files/Backups ====================
set noswapfile
set nobackup
set undofile
set nowritebackup
set hidden

" ==================== Window Management ====================
set splitbelow                       " force all horizontal splits to go below current window
set splitright                       " force all vertical splits to go to the right of current window
set sessionoptions+=winpos,terminal,folds

" ==================== Performance/Misc ====================
set history=1500 " Remember 1000 lines
set clipboard+=unnamedplus
set mouse=a
set encoding=utf-8
" Default is 4000 MS instead 300
set updatetime=300
set shortmess+=c

" ==================== Wildmenu/Completion ====================
set wildmenu
set wildmode=longest:full,full
set wildignore=*.jpg,*.png,*.gif,*.pdf,*.pyc,*.flv,*.img,*.xlsx,*.psd,*.jpeg

" ==================== Plugin Configurations ====================
let g:netrw_browsex_viewer="chrome"
let mapleader=","
let g:barbar_auto_setup = v:false
let g:coc_global_extensions = ['coc-json', 'coc-css', 'coc-html', 'coc-clangd', 'coc-eslint', 'coc-flutter-tools', 'coc-tsserver', 'coc-go', 'coc-git', 'coc-rust-analyzer', 'coc-java', 'coc-vimlsp', 'coc-lua', 'coc-golines']
let g:python3_host_prog = '/usr/bin/python3'
" disable perl
let g:loaded_perl_provider = 0
let g:UltiSnipsSnippetDirectories=['UltiSnips', $HOME.'/.config/nvim/ultisnips/dart.snippets', 'ultisnips']
"To configure lightline, add the following line:
let g:palenight_terminal_italics=1
"One dark config
let g:onedark_config = {'style': 'darker'}

let g:dart_format_on_save = 0 " Pass "1" if you want automatic format on save current buffer
let g:dartfmt_options = ['--fix', '--line-length 90']
let g:dart_style_guide = 2

" let g:signify_sign_show_count = 0
" let g:signify_sign_show_text = 1
" let g:signify_sign_change = '~'

let g:lsc_auto_map = v:true
let g:auto_session_root_dir = "~/.nvim_sessions" 

" ==================== LUA Section ====================
lua << EOF
vim.fn.sign_define("DiagnosticSignError", { text = " ", texthl = "DiagnosticSignError" })
vim.fn.sign_define("DiagnosticSignWarn", { text = " ", texthl = "DiagnosticSignWarn" })
vim.fn.sign_define("DiagnosticSignInfo", { text = " ", texthl = "DiagnosticSignInfo" }) 
vim.fn.sign_define("DiagnosticSignHint", { text = "󰌵", texthl = "DiagnosticSignHint" })
EOF
