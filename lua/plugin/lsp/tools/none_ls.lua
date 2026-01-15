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
    format.bibclean,
    format.stylua,
    format.clang_format,
    format.cmake_format.with {
      cmd = "cmake-format",
    },
    -- Actions
    actions.gitsigns,
  },
})
