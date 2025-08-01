local M = {}
local utils = require("plugin.lsp.utils.utils")
local code_lens = require("plugin.lsp.tools.code_lenses")
local debugger = require("plugin.lsp.configs.debugger")
local flutter_setup = require("plugin.lsp.tools.flutter-tools")
local cmake_setup = require("plugin.lsp.tools.cmake-tools")
local diagnostics = require("plugin.lsp.configs.lsp_diagnostics_configs")
local servers = require("plugin.lsp.configs.languages")
local lspconfig = require("lspconfig")
local lsp_utils = require('lspconfig.util')
local default_capabilities = require("plugin.lsp.configs.capabilities")

--- setup all the LSP used by these configurations
function M.setup()
  local capabilities = default_capabilities.get_capabilities()
  vim.lsp.enable(servers.languages)
  M.config_lsp_langs(capabilities)
  diagnostics.setup_config()
  code_lens.setup()
  debugger.setup()

  lspconfig.tailwindcss.setup({
    on_attach = function(client, bufnr)
      require('plugin.colorizer')
    end,
    settings = {
      tailwindCSS = {
        experimental = {
          classRegex = {
            "tw`([^`]*)",           -- Ej: tw`text-red-500`
            "className=\"([^\"]*)", -- HTML/JSX
            "class:\\s*\"([^\"]*)", -- Clases dinámicas
            "classList=\\s*\"([^\"]*)",
            "cn\\(([^)]*)\\)",      -- Soporte para librerías como `classnames`
          },
        },
        emmetCompletions = true, -- Habilita autocompletado tipo Emmet
      },
    },
    filetypes = {
      "html", "javascript", "javascriptreact", "typescript", "typescriptreact",
      "svelte", "vue", "astro", "php", "blade", "twig", "markdown", "mdx"
    },
  })
  lspconfig.jsonls.setup({ capabilities = capabilities })
  require('plugin.jdtls')

  flutter_setup.setup(capabilities)
  cmake_setup.setup()

  utils.create_autocmds()
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
      require('plugin.colorizer')
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
    on_attach = function(client, bufnr)
      require('plugin.colorizer')
    end,
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
      require('plugin.colorizer')
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
    on_attach = function(client, bufnr)
      require('plugin.colorizer')
      vim.lsp.inlay_hint.enable(true, { bufnr = bufnr })
    end,
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

  vim.lsp.config('html', {
    capabilities = capabilities,
    on_attach = function(client, bufnr)
      require('plugin.colorizer')
    end,
  })

  vim.lsp.config('dockerls', {
    capabilities = capabilities,
    on_attach = function(client, bufnr)
      require('plugin.colorizer')
    end,
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
end

M.hover_opts = {
  border = 'rounded',
  max_width = 45,
  max_height = 20,
  anchor_bias = 'below', --Determines where put the popup: | above | below | auto |
}

return {
  setup = M.setup,
  hover_opts = M.hover_opts,
}
