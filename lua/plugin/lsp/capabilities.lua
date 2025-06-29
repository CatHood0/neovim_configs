local M = {}
local cmp_lsp = require('cmp_nvim_lsp')

function M.get_capabilities()
  local capabilities = vim.lsp.protocol.make_client_capabilities()
  capabilities.workspace.configuration = true
  capabilities.workspace.workspaceEdit.documentChanges = true
  capabilities.textDocument.completion.completionItem.snippetSupport = true
  capabilities.textDocument.diagnostic = {
    dynamicRegistration = true,
    codeDescriptionSupport = true,
    dataSupport = true,
    relatedInformation = true,
  }
  -- @see: https://github.com/hrsh7th/nvim-compe#how-to-use-lsp-snippet
  capabilities.textDocument.completion.completionItem.resolveSupport = {
    properties = { "documentation", "detail", "additionalTextEdits" },
  }

  return cmp_lsp.default_capabilities(capabilities) or capabilities
end
return M
