local M = {}

function M.setup_config()
  vim.diagnostic.config({
    signs = {
      enable = true,
      text = {
        [vim.diagnostic.severity.ERROR] = " ",
        [vim.diagnostic.severity.WARN]  = " ",
        [vim.diagnostic.severity.INFO]  = " ",
        [vim.diagnostic.severity.HINT]  = "󰌵 ",
      },
      texthl = {
        [vim.diagnostic.severity.ERROR] = "DiagnosticSignError",
        [vim.diagnostic.severity.WARN]  = "DiagnosticSignWarn",
        [vim.diagnostic.severity.INFO]  = "DiagnosticSignInfo",
        [vim.diagnostic.severity.HINT]  = "DiagnosticSignHint",
      },
      numhl = {
        [vim.diagnostic.severity.ERROR] = "DiagnosticSignError",
        [vim.diagnostic.severity.WARN]  = "DiagnosticSignWarn",
        [vim.diagnostic.severity.INFO]  = "DiagnosticSignInfo",
        [vim.diagnostic.severity.HINT]  = "DiagnosticSignHint",
      },
    },
    virtual_text = {
      source = true,
      current_line = false,
      spacing = 1,
    },
    underline = true,
    float = {
      show_header = false,
      source = 'if_many',
      border = 'rounded',
      update_in_insert = true,
      severity_sort = true,
    },
    update_in_insert = true,
    severity_sort = true,
  })
end

return M
