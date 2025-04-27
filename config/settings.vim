"set wrap
set number
set cursorline
set noswapfile
set scrolloff=10
set iskeyword+=-
set ignorecase
set pumheight=0
"set wrapmargin=10
set showcmd
" set showmatch
"set paste
set showtabline=2                    " always show tabs
set smartcase                        " smart case
set nosmartindent                    " make indenting smarter again
set splitbelow                       " force all horizontal splits to go below current window
set splitright                       " force all vertical splits to go to the right of current window
set history=1500 " Remember 1000 lines
set clipboard+=unnamedplus
" auto completition on tab
set wildmenu
set wildmode=longest:full,full
set wildignore=*.docx,*.jpg,*.png,*.gif,*.pdf,*.pyc,*.exe,*.flv,*.img,*.xlsx,*.odt,*.psd,*.jpeg,*.wepb
set nobackup
set colorcolumn=120
set textwidth=300
" set scrollbind     sync the scroll for all windows on vim 
set undofile
set hlsearch
set incsearch
set expandtab
set autoindent
set tabstop=2
set softtabstop=2
set shiftwidth=2
set backspace=indent,eol,start
set mouse=a
set encoding=utf-8
set hidden
set nowritebackup
set signcolumn=yes
" Default is 4000 MS instead 300
set updatetime=300
set shortmess+=c
"""""highlight the column where the wrapping will be made
syntax on
filetype plugin indent on
" Spelling correction
" set spell spelllang=en_us
set laststatus=2
set sessionoptions+=winpos,terminal,folds

let g:netrw_browsex_viewer="zen"
set background=dark " or light if you want light mode
let mapleader=","
let g:barbar_auto_setup = v:false

let g:coc_global_extensions = ['coc-json', 'coc-css', 'coc-html', 'coc-clangd', 'coc-prettier', 'coc-eslint', 'coc-flutter-tools']

let g:python3_host_prog = '/usr/bin/python3'
" disable perl
let g:loaded_perl_provider = 0
let g:UltiSnipsSnippetDirectories=['UltiSnips', $HOME.'/.config/nvim/ultisnips/dart.snippets', 'ultisnips']
"To configure lightline, add the following line:
let g:palenight_terminal_italics=1
"One dark config
let g:onedark_config = {'style': 'darker'}

