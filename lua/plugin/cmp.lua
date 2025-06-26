local cmp = require('cmp')

cmp.setup.cmdline({ '/', '?' }, {
  mapping = cmp.mapping.preset.cmdline(),
	sources = {
   { name = 'buffer' }
  }
})

cmp.setup.cmdline(':', {
  mapping = cmp.mapping.preset.cmdline(),
  sources = cmp.config.sources({
    { name = 'path' }
  }, {
    { name = 'cmdline' }
  }),
  matching = { disallow_symbol_nonprefix_matching = false }
})

-- Deshabilitar autocompletado en ciertos tipos de buffers
vim.api.nvim_create_autocmd('FileType', {
  pattern = { 'TelescopePrompt', 'neo-tree', 'qf' },
  callback = function()
    cmp.setup.buffer({ enabled = false })
  end
})
