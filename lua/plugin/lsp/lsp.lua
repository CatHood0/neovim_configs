local M = {}
local utils = require("plugin.lsp.utils")
local code_lens = require("plugin.lsp.code_lenses")
local flutter_setup = require("plugin.lsp.flutter-tools")
local diagnostics = require("plugin.lsp.lsp_diagnostics_configs")
local servers = require("plugin.lsp.languages")
local lspconfig = require("lspconfig")
local default_capabilities = require("plugin.lsp.capabilities")

--- setup all the LSP used by these configurations
function M.setup()
  local capabilities = default_capabilities.get_capabilities()
  M.config_lsp_langs(capabilities)
  diagnostics.setup_config()
  code_lens.setup()

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

function M.config_lsp_langs(capabilities)
  vim.lsp.config('rust_analyzer', {
    capabilities = capabilities,
    settings = {
      ['rust-analyzer'] = {
        checkOnSave = true,
        check = {
          features = "all"
        },
        cargo = {
          buildScripts = {
            rebuildOnSave = true
          }
        },
        joinLines = {
          joinElseIf = true
        },
        updates = {
          checkOnStartup = true
        },
        completion = {
          postfix = {
            enable = true
          }
        }
      },
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
        codelens = {
          enable = true,
        },
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
        telemetry = { enable = false },
        codelens = {
          enable = true,
        },
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
    settings = {
      filetypes = {
        "javascript",
        "typescript",
      },
      codelens = {
        enable = true,
      },
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
