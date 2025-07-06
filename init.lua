local lazypath = vim.fn.stdpath('data') .. '/lazy/lazy.nvim'

if not vim.loop.fs_stat(lazypath) then
  vim.fn.system({
    'git',
    'clone',
    '--filter=blob:none',
    'https://github.com/folke/lazy.nvim.git',
    '--branch=stable',
    lazypath,
  })
end

vim.opt.rtp:prepend(lazypath)

require('lazy').setup(require('config.plugins'))

require('config.settings')
require('config.keymapping')

-- Load plugin configurations
require('plugin.autopair')
require('plugin.autossesion')
require('plugin.bufferline')
require('plugin.cmp')
require('plugin.cursors')
require('plugin.dap')
require('plugin.dashboard')
require('plugin.gitsigns')
require('plugin.indent_line')
require('plugin.lualine')
require('plugin.neotree')
require('plugin.neogit')
require('plugin.noice')
require('plugin.notify')
require('plugin.mini_clues')
require('plugin.pubspec-assist')
require('plugin.telescope')
require('plugin.tmux')
require('plugin.toggleterm')
require('plugin.treesitter')
require('plugin.lspkind')
require('plugin.lsp.lsp').setup()

-- Load core
require('core.winbar.nbreadcrumbs').setup({
  enabled = true,
  separator = "»",
  show_diagnostic = true,
  icons_provider = 'nvim-web-devicons',
})

require('plugin.themes').theme()

vim.api.nvim_create_user_command("SetDebug", function() vim.lsp.set_log_level("debug") end, {})
vim.api.nvim_create_user_command("SetWarnings", function() vim.lsp.set_log_level("warn") end, {})
vim.api.nvim_create_user_command("SetOff", function() vim.lsp.set_log_level("off") end, {})
