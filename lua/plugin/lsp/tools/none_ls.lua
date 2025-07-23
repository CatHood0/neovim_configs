local null_ls = require("null-ls")
local builtins = null_ls.builtins
local format = builtins.formatting
local actions = builtins.code_actions
local diag = builtins.diagnostics
local completion = builtins.completion

null_ls.setup({
  sources = {
    -- Diagnostics,
    diag.ltrs,
    diag.hadolint,
    -- Formatting
    format.prettier.with({ -- JS/TS/HTML/CSS
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
    format.bibclean,
    format.stylua,
    format.yamlfmt,
    format.clang_format,
    format.cmake_format.with {
      cmd = "cmake-format",
    },
    format.shfmt.with {
      args = { "-s", "-i", "4" },
    },
    format.uncrustify,
    -- Actions
    actions.gitsigns,
    -- Completions
    completion.spell,
  },
})
