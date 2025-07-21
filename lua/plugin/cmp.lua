local cmp = require('cmp')

local luasnip = require("luasnip")
local lspkind = require("lspkind")
local tailwind_formatter = require('tailwindcss-colorizer-cmp')
require("luasnip.loaders.from_vscode").lazy_load()

local symbols_formatter = lspkind.cmp_format({
  mode = "symbol_text",
  maxwidth = 40,
  ellipsis_char = "...",
  show_labelDetails = true,
  symbol_map = {
    Copilot = "",
  },
})

cmp.setup({
  event = { "InsertEnter", "CmdlineEnter" },
  completion = { completeopt = "menu,menuone,noselect,noinsert" },
  -- the suggestion floating menu UI configs
  window = {
    completion = cmp.config.window.bordered({
      border = 'rounded', -- 'single', 'double', 'rounded', 'none'
      winhighlight = 'FloatBorder:FloatBorder,Normal:CmpPmenu',
      scrollbar = true,
      max_width = 50,
      max_height = 20,
      side_padding = 1,
    }),
    documentation = cmp.config.window.bordered({
      border = 'rounded', -- 'single', 'double', 'rounded', 'none'
      winhighlight = 'FloatBorder:FloatBorder,Normal:CmpPmenu',
      scrollbar = true,
      max_width = 50,
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
    ['<C-n>'] = cmp.mapping.scroll_docs(-4),
    ['<C-p>'] = cmp.mapping.scroll_docs(4),
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
    fields = { 'abbr', 'kind', 'menu' },
    format = function(entry, item)
      local effective_format = symbols_formatter(entry, item)
      local colored_item = tailwind_formatter.formatter(entry, effective_format)
      return colored_item
    end
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

cmp.setup.filetype({ "dap-repl", "dapui_watches" }, {
  sources = cmp.config.sources({
    { name = "dap" },
  }, {
    { name = "buffer" },
  }),
})

-- Deshabilitar autocompletado en ciertos tipos de buffers
vim.api.nvim_create_autocmd('FileType', {
  pattern = { 'TelescopePrompt', 'neo-tree', 'qf' },
  callback = function()
    cmp.setup.buffer({ enabled = false })
  end
})
