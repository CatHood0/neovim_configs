lua << EOF
local cmp = require('cmp')

cmp.setup({
  -- Configuración para buffers normales
  sources = cmp.config.sources({
    { name = 'buffer' },
    { name = 'path' }
  }),

  -- Configuración para línea de comandos
  cmdline = {
    [':'] = {
      mapping = cmp.mapping.preset.cmdline(),
      sources = cmp.config.sources({
        { name = 'path' },
        { name = 'cmdline' }
      })
    },
    ['/'] = {
      mapping = cmp.mapping.preset.cmdline(),
      sources = {
        { name = 'buffer' }
      },
      matching = { disallow_symbol_nonprefix_matching = false }
    }
  }
})

-- Deshabilitar autocompletado en ciertos tipos de buffers
vim.api.nvim_create_autocmd('FileType', {
  pattern = { 'TelescopePrompt', 'neo-tree', 'qf' },
  callback = function()
    cmp.setup.buffer({ enabled = false })
  end
})
EOF

lua << EOF
require("mason").setup()
require("mason-lspconfig").setup()
EOF
