local cmp = require('cmp')

local luasnip = require("luasnip")
local lspkind = require("lspkind")
require("luasnip.loaders.from_vscode").lazy_load()

cmp.setup({
  event = { "InsertEnter", "CmdlineEnter" },
  completion = { completeopt = "menu,menuone,noselect,noinsert" },
  -- the suggestion floating menu UI configs
  window = {
    completion = cmp.config.window.bordered({
      border = 'single', -- 'single', 'double', 'rounded', 'none'
      winhighlight = 'FloatBorder:FloatBorder,Normal:CmpPmenu',
      scrollbar = true,
      max_width = 80,
      max_height = 20,
      side_padding = 1,
    }),
    documentation = cmp.config.window.bordered({
      border = 'single', -- 'single', 'double', 'rounded', 'none'
      winhighlight = 'FloatBorder:FloatBorder,Normal:CmpPmenu',
      scrollbar = true,
      max_width = 80,
      max_height = 20,
      side_padding = 1,
    }),
  },
  snippet = {
    expand = function(args)
      luasnip.lsp_expand(args.body)
    end,
  },
  mapping = {
    ['<C-b>'] = cmp.mapping.scroll_docs(-4),
    ['<C-f>'] = cmp.mapping.scroll_docs(4),
    ['<C-space>'] = cmp.mapping.complete(),
    ['<C-e>'] = cmp.mapping.abort(),
    ['<CR>'] = cmp.mapping.confirm {
      behavior = cmp.ConfirmBehavior.Insert,
      select = true,
    },
    ['<C-j>'] = cmp.mapping.select_next_item(),
    ['<down>'] = cmp.mapping.select_next_item(),
    ['<C-k>'] = cmp.mapping.select_prev_item(),
    ['<up>'] = cmp.mapping.select_prev_item(),
  },
  -- sources for autocompletion
  sources = {
    { name = 'nvim_lsp' },
    { name = 'luasnip' },
    { name = "buffer" },
    { name = "path" },
  },
  formatting = {
    expandable_indicator = true,
    format = lspkind.cmp_format({
      mode = "symbol_text",
      maxwidth = 70,
      ellipsis_char = "...",
      show_labelDetails = true, -- show labelDetails in menu. Disabled by default
      symbol_map = {
        Copilot = "",
      },
    }),
  },
})

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
