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
require('plugin.noice')
require('plugin.notify')
require('plugin.pubspec-assist')
require('plugin.telescope')
require('plugin.tmux')
require('plugin.toggleterm')
require('plugin.treesitter')

-- Load core
require('core.winbar.nbreadcrumbs').setup()
require('core.diagnostics.coc_diagnostic_adapter').setup()

require('plugin.themes').theme()
require('plugin.coc').setup()

-- Devicons and Winbar setup
local devicons_ok, devicons = pcall(require, 'nvim-web-devicons')
if not devicons_ok then
  vim.notify("Could not load nvim-web-devicons", vim.log.levels.WARN)
else
  devicons.setup({
    override = {
      folder = {
        icon = "",
        color = "#7ebae4",
        name = "folder"
      }
    }
  })

  require('core.winbar.nbreadcrumbs').setup({
    enabled = true,
    separator = "»",
    show_diagnostic = true,
    use_nui = true,
    on_get_folder = function(_)
      local icon, color = devicons.get_icon("folder", "", { default = true })
      return icon, color
    end,
    on_get_file = function(name, ext)
      local icon, color = devicons.get_icon(name, ext, { default = true })
      return icon, color
    end,
  })
end
