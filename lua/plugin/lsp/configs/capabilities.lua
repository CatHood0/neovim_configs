local M = {}
local cmp_lsp = require('cmp_nvim_lsp')

function M.get_capabilities()
  local capabilities = vim.lsp.protocol.make_client_capabilities()

  local custom_capabilities = {
    workspace = {
      configuration = true,
      workspaceEdit = {
        documentChanges = true
      }
    },
    textDocument = {
      completion = {
        completionItem = {
          snippetSupport = true,
          resolveSupport = {
            properties = { "documentation", "detail", "additionalTextEdits" }
          }
        }
      },
      diagnostic = {
        dynamicRegistration = true,
        codeDescriptionSupport = true,
        dataSupport = true,
        relatedInformation = true,
        relatedDocumentSupport = true,
      },
      colorProvider = {
        dynamicRegistration = true,
      },
      foldingRange = {
        dynamicRegistration = false,
        lineFoldingOnly = true,
      }
    }
  }

  return vim.tbl_deep_extend('force',
    cmp_lsp.default_capabilities(),
    capabilities,
    custom_capabilities
  )
end

return M
