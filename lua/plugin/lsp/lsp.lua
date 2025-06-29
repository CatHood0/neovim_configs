local M = {}
local utils = require("plugin.lsp.utils")
local flutter_setup = require("plugin.lsp.flutter-tools")
local diagnostics = require("plugin.lsp.lsp_diagnostics_configs")
local servers = require("plugin.lsp.languages")
local lspconfig = require("lspconfig")
local default_capabilities = require("plugin.lsp.capabilities")

function M.setup()
  local capabilities = default_capabilities.get_capabilities()
  -- ======================== JSON ==========================
  M.configLanguages(capabilities)
  diagnostics.setup_config()

  lspconfig.jsonls.setup({ capabilities = capabilities })
  lspconfig.clangd.setup({ capabilities = capabilities })
  lspconfig.lua_ls.setup({ capabilities = capabilities })
  lspconfig.gopls.setup({ capabilities = capabilities })
  lspconfig.rust_analyzer.setup({ capabilities = capabilities })
  lspconfig.jdtls.setup({ capabilities = capabilities })
  require('plugin.jdtls')

  flutter_setup.setup(capabilities)

  utils.create_autocmds()
  vim.lsp.enable(servers.languages)
end

function M.configLanguages(capabilities)
  vim.lsp.config('rust_analyzer', {
    capabilities = capabilities,
    settings = {
      ['rust-analyzer'] = {},
    },
  })
  vim.lsp.config('gopls', {
    capabilities = capabilities,
    settings = {
      gopls = {
        analyses = {
          unusedparams = true,
        },
        staticcheck = true,
        gofumpt = true,
      },
    },
  })
  vim.lsp.config('lua_ls', {
    capabilities = capabilities,
    settings = {
      ['Lua'] = {
        runtime = { version = 'LuaJIT' },
        diagnostics = { globals = { 'vim' } },
        workspace = {
          library = vim.env.VIMRUNTIME,
          checkThirdParty = false,
        },
        telemetry = { enable = false }
      }
    }
  })

  vim.lsp.config('cssls', {
    capabilities = capabilities,
  })

  vim.lsp.config('dockerls', {
    capabilities = capabilities,
    settings = {
      docker = {
        languageserver = {
          formatter = {
            ignoreMultilineInstructions = true,
          },
        },
      }
    }
  })

  vim.lsp.config('ts_ls', {
    filetypes = {
      "javascript",
      "typescript",
    },
  })
end

M.hover_opts = {
  border = 'rounded',
  max_width = 80,
  max_height = 30,
  anchor_bias = 'below', --Determines where put the popup: | above | below | auto |
}

return {
  setup = M.setup,
  hover_opts = M.hover_opts,
}
