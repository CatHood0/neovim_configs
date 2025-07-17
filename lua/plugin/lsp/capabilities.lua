local M = {}
local cmp_lsp = require('cmp_nvim_lsp')

function M.get_capabilities()
  local capabilities = vim.lsp.protocol.make_client_capabilities()
  capabilities.workspace.configuration = true
  capabilities.workspace.workspaceEdit.documentChanges = true
  capabilities.workspace.inlayHint = {
    refreshSupport = true,
  }
  capabilities.workspace.didChangeWatchedFiles = {
    dynamicRegistration = true,
    relativePatternSupport = true,
  }

  capabilities.textDocument.completion.completionItem.snippetSupport = true
  capabilities.textDocument.diagnostic = {
    dynamicRegistration = true,
    codeDescriptionSupport = true,
    dataSupport = true,
    relatedInformation = true,
  }
  capabilities.textDocument.colorProvider = {
    dynamicRegistration = true,
  }
  -- @see: https://github.com/hrsh7th/nvim-compe#how-to-use-lsp-snippet
  capabilities.textDocument.completion.completionItem.resolveSupport = {
    properties = { "documentation", "detail", "additionalTextEdits" },
  }

  -- Configure folding capabilities that aren't sended
  -- by default (useful for folding)
  capabilities.textDocument.foldingRange = {
    dynamicRegistration = false,
    lineFoldingOnly = true
  }

  return cmp_lsp.default_capabilities(capabilities) or capabilities
end

return M
