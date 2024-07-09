set wrap
set number
set cursorline
set noswapfile
set scrolloff=10
set iskeyword+=-
set ignorecase
set pumheight=10
"set wrapmargin=10
set showcmd
" set showmatch
"set paste
set showtabline=2                         " always show tabs
set smartcase                        " smart case
set nosmartindent                      " make indenting smarter again
set splitbelow                       " force all horizontal splits to go below current window
set splitright                       " force all vertical splits to go to the right of current window
set history=1000 " Remenber 1000 lines
set clipboard+=unnamedplus
" auto completition on tab
set wildmenu
set wildmode=longest:full,full
set wildignore=*.docx,*.jpg,*.png,*.gif,*.pdf,*.pyc,*.exe,*.flv,*.img,*.xlsx
set nobackup
set colorcolumn=120
set textwidth=140
" set scrollbind     sync the scroll for all windows on vim 
set undofile
set hlsearch
set incsearch
set expandtab
set autoindent
set tabstop=4
set softtabstop=4
set shiftwidth=4
set backspace=indent,eol,start
set mouse=a
set encoding=utf-8
set hidden
set nowritebackup
" Default is 4000 MS instead 300
set updatetime=300
set shortmess+=c
syntax on
filetype plugin indent on
" Spelling correction
" set spell spelllang=en_us
set laststatus=2
"let g:netrw_browsex_viewer="chrome"
set background=dark " or light if you want light mode
let mapleader=","
let g:coc_global_extensions = ['coc-json', 'coc-html', 'coc-tsserver', 'coc-xml', 'coc-prettier', 'coc-eslint', 'coc-flutter']
let g:python3_host_prog = expand('~/.venvs/nvim/bin/python')
let g:UltiSnipsSnippetDirectories=['UltiSnips', $HOME.'/.config/nvim/ultisnips/dart.snippets', 'ultisnips']
"To configure lightline, add the following line:
let g:palenight_terminal_italics=1
"One dark config
let g:onedark_config = {
    \ 'style': 'darker',
\}
