local cmp = require('cmp')
local compare = require('cmp.config.compare')

local luasnip = require("luasnip")
local lspkind = require("lspkind")
require("luasnip.loaders.from_vscode").lazy_load()

local symbols_formatter = lspkind.cmp_format({
  mode = "symbol",
  maxwidth = 40,
  max_width = 40,
  ellipsis_char = "...",
  show_labelDetails = false,
  symbol_map = {
    Copilot = "  ",
  },
})

cmp.setup({
  event = { "InsertEnter", "CmdlineEnter" },
  completion = { completeopt = "menu,menuone,noselect,noinsert" },
  sorting = {
    priority_weight = 1,
    comparators = {
      ---scopes: Entries defined in a closer scope will be ranked higher (e.g., prefer local variables to globals).
      -- compare.scopes,
      ---offset: Entries with smaller offset will be ranked higher.
      compare.offset,
      ---score: Entries with higher score will be ranked higher.
      compare.score,
      ---exact: Entries with exact == true will be ranked higher.
      compare.exact,
      ---kind: Entries with smaller ordinal value of 'kind' will be ranked higher.
      ---(see lsp.CompletionItemKind enum).
      ---Exceptions are that Text(1) will be ranked the lowest, and snippets be the highest.
      compare.kind,
    },
  },
  -- default config
  view = {
    entries = {
      name = 'custom',
      selection_order = 'top_down',
      follow_cursor = false,
    },
    docs = {
      auto_open = true,
    },
  },
  matching = {
    disallow_fuzzy_matching = false,
    disallow_fullfuzzy_matching = false,
    disallow_partial_fuzzy_matching = true,
    disallow_partial_matching = false,
    disallow_prefix_unmatching = false,
    disallow_symbol_nonprefix_matching = true,
  },
  -- the suggestion floating menu UI configs
  window = {
    completion = cmp.config.window.bordered({
      border = 'none', -- 'single', 'double', 'rounded', 'none'
      winhighlight = 'FloatBorder:Pmenu,Normal:Pmenu,CursorLine:PmenuSel',
      scrollbar = true,
      max_width = 50,
      max_height = 5,
      side_padding = 1,
    }),
    documentation = cmp.config.window.bordered({
      border = 'rounded', -- 'single', 'double', 'rounded', 'none'
      -- winhighlight = 'FloatBorder:FloatBorder,Normal:CmpPmenu',
      winhighlight = 'FloatBorder:Pmenu,Normal:Pmenu,CursorLine:PmenuSel',
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
    ['<C-m>'] = cmp.mapping.scroll_docs(-4),
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
    -- per_filetype = {
    --   codecompanion = { "codecompanion" },
    -- },
    { name = 'nvim_lsp', priority = 1000 },
    { name = 'luasnip',  priority = 750 },
    { name = "buffer",   priority = 500 },
    { name = "path",     priority = 250 },
  },
  formatting = {
    expandable_indicator = true,
    fields = { 'kind', 'abbr', 'menu' },
    format = function(entry, item)
      return symbols_formatter(entry, item)
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
