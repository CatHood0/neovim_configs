function _G.line_fold()
  local line = vim.fn.getline(vim.v.foldstart)
  return line
end

-- ==================== UI/Visual ====================
vim.opt.number = true
vim.opt.cursorline = true
vim.opt.scrolloff = 8
vim.opt.sidescrolloff = 8
vim.opt.showcmd = true
-- allow to show bufferline
vim.opt.showtabline = 2
vim.opt.colorcolumn = "120"
vim.opt.hlsearch = true
vim.opt.pumheight = 0
-- vim.cmd("syntax on")
vim.opt.background = "dark" -- or light if you want light mode
vim.opt.laststatus = 2
vim.opt.signcolumn = "yes"
vim.opt.textwidth = 200
vim.opt.diffopt = {
  'internal',
  'filler',
  'closeoff',
  'context:12',
  'algorithm:histogram',
  'linematch:200',
  'indent-heuristic',
}

-- ==================== Folding =====================
vim.o.foldenable = true
vim.o.foldlevel = 99
vim.o.foldmethod = "expr"
vim.o.foldexpr = "v:lua.vim.treesitter.foldexpr()"
-- Official documentation:
--
-- 'foldcolumn' is a number, which sets the width for a column on the side of the
-- window to indicate folds.  When it is zero, there is no foldcolumn.  A normal
-- value is auto:9. The maximum is 9.
vim.o.foldcolumn = 'auto:9'
vim.o.foldtext = ""
vim.o.foldtext = "v:lua.line_fold()"
vim.opt.fillchars = {
  foldopen = "",
  foldclose = "",
  foldsep = "│",
  eob = " ",
  fold = " ",
  diff = '╱',
}
vim.cmd([[
    highlight Folded guifg=#7aa2f7 guibg=NONE
    highlight FoldVirtual guifg=#e0af68 gui=bold
]])

-- ==================== Text/Editing ====================
vim.opt.wrap = true
vim.opt.expandtab = true
vim.opt.autoindent = true
vim.opt.smartindent = false -- make indenting smarter again
vim.opt.tabstop = 2
vim.opt.softtabstop = 2
vim.opt.shiftwidth = 2
vim.opt.backspace = "indent,eol,start"
vim.opt.iskeyword:append("-")
vim.cmd("filetype plugin indent on")

-- ==================== Search ====================
vim.opt.ignorecase = true
vim.opt.smartcase = true -- smart case
vim.opt.incsearch = true

-- ==================== Files/Backups ====================
vim.opt.swapfile = false
vim.opt.backup = false
vim.opt.undofile = true
vim.opt.writebackup = false
vim.opt.hidden = true

-- ==================== Window Management ====================
vim.opt.splitbelow = true -- force all horizontal splits to go below current window
vim.opt.splitright = true -- force all vertical splits to go to the right of current window
vim.opt.sessionoptions:append({ "winpos", "terminal", "folds" })

-- ==================== Performance/Misc ====================
vim.opt.history = 1500 -- Remember 1500 lines
vim.opt.clipboard = "unnamedplus"
vim.opt.mouse = "a"
vim.o.mousemoveevent = true
vim.opt.encoding = "utf-8"
vim.opt.updatetime = 300
vim.opt.shortmess:append("c")

-- ==================== Wildmenu/Completion ====================
vim.opt.wildmenu = true
vim.opt.wildmode = "longest:full,full"
vim.opt.wildignore = "*.jpg,*.png,*.gif,*.pdf,*.pyc,*.flv,*.img,*.xlsx,*.psd,*.jpeg"

-- ==================== Plugin Configurations ====================
vim.g.netrw_browsex_viewer = "chrome"
vim.g.mapleader = ","
vim.g.python3_host_prog = '/usr/bin/python3'
vim.g.loaded_perl_provider = 0 -- disable perl
vim.g.UltiSnipsSnippetDirectories = {
  'UltiSnips',
  vim.env.HOME .. '/.config/nvim/ultisnips/dart.snippets',
  'ultisnips'
}
vim.g.palenight_terminal_italics = 1        -- To configure lightline
vim.g.onedark_config = { style = 'darker' } -- One dark config

-- Dart settings
vim.g.dart_format_on_save = 0 -- Pass "1" if you want automatic format on save current buffer
vim.g.dartfmt_options = { '--fix', '--line-length 90' }
vim.g.dart_style_guide = 2

-- LSC settings
vim.g.lsc_auto_map = true
vim.g.auto_session_root_dir = "~/.nvim_sessions"
