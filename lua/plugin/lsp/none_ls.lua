local null_ls = require("null-ls")
local augroup = vim.api.nvim_create_augroup("LspFormatting", {})

null_ls.setup({
  sources = {
    null_ls.builtins.diagnostics.ltrs,
    null_ls.builtins.formatting.prettier.with({ -- JS/TS/HTML/CSS
      filetypes = {
        "javascript",
        "typescript",
        "typescriptreact",
        "javascriptreact",
        "vue",
        "css",
        "scss",
        "html",
        "json",
        "yaml",
      },
      extra_args = { "--single-quote", "--jsx-single-quote" },
    }),
    -- === Code Actions ===
    null_ls.builtins.code_actions.gitsigns, -- Acciones de Git
  },
})
