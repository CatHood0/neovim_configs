local M = {}
local utils = require("plugin.lsp.utils")
local code_lens = require("plugin.lsp.code_lenses")
local flutter_setup = require("plugin.lsp.flutter-tools")
local cmake_setup = require("plugin.lsp.cmake-tools")
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
  cmake_setup.setup()

  utils.create_autocmds()
  vim.lsp.enable(servers.languages)
end

function M.config_lsp_langs(capabilities)
  --- Curious option of the Config class
  --- Predicate used to decide if a client should be re-used. Used on all
  --- running clients. The default implementation re-uses a client if name and
  --- root_dir matches.
  --- reuse_client? fun(client: vim.lsp.Client, config: vim.lsp.ClientConfig): boolean
  vim.lsp.config('rust_analyzer', {
    capabilities = capabilities,
    on_attach = function(client, bufnr)
      vim.lsp.inlay_hint.enable(true, { bufnr = bufnr })
    end,
    settings = {
      ['rust-analyzer'] = {
        checkOnSave = true,
        check = {
          features = "all"
        },
        files = {
          exclude = {
            "~/",
            "~/.cargo/**",
            "~/.rustup/**"
          },
        },
        cargo = {
          buildScripts = {
            rebuildOnSave = true
          }
        },
        joinLines = {
          joinElseIf = true
        },
        completion = {
          postfix = {
            enable = true
          }
        }
      },
    },
  })

  vim.lsp.config("clangd", {
    settings = {
      clangd = {
        InlayHints = {
          Designators = true,
          Enabled = true,
          ParameterNames = true,
          DeducedTypes = true,
        },
        fallbackFlags = { "-std=c++20" },
      },
    },
  })

  vim.lsp.config('gopls', {
    capabilities = capabilities,
    on_attach = function(client, bufnr)
      vim.lsp.inlay_hint.enable(true, { bufnr = bufnr })
    end,
    settings = {
      gopls = {
        analyses = {
          unusedparams = true,
        },
        staticcheck = true,
        gofumpt = true,
        hints = {
          rangeVariableTypes = true,
          parameterNames = true,
          constantValues = true,
          assignVariableTypes = true,
          compositeLiteralFields = true,
          compositeLiteralTypes = true,
          functionTypeParameters = true,
        },
        codelens = {
          enable = true,
        },
      },
    },
  })
  vim.lsp.config('lua_ls', {
    capabilities = capabilities,
    on_attach = function(client, bufnr)
      vim.lsp.inlay_hint.enable(true, { bufnr = bufnr })
    end,
    settings = {
      Lua = {
        runtime = { version = 'LuaJIT' },
        diagnostics = { globals = { 'vim' } },
        workspace = {
          library = vim.env.VIMRUNTIME,
          checkThirdParty = false,
        },
        hint = {
          enable = true,
          arrayIndex = "Enable",
          paramName = "All"
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
    settings = {
      css = {
        inlayHints = {
          enable = true,
          showParameterNames = true,
          parameterHintsPrefix = "<- ",
          otherHintsPrefix = "=> ",
        },
      },
    },
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

        inlayHints = {
          enable = true,
          showParameterNames = true,
          parameterHintsPrefix = "<- ",
          otherHintsPrefix = "=> ",
        },
      }
    }
  })

  vim.lsp.config('ts_ls', {
    settings = {
      ['Ts'] = {
        filetypes = {
          "javascript",
          "typescript",
        },
        codelens = {
          enable = true,
        },
        inlayHints = {
          enable = true,
          showParameterNames = true,
          parameterHintsPrefix = "<- ",
          otherHintsPrefix = "=> ",
        },
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
