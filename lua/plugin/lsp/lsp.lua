local M = {}
local utils = require("plugin.lsp.utils.utils")
local code_lens = require("plugin.lsp.tools.code_lenses")
local debugger = require("plugin.lsp.configs.debugger")
local flutter_setup = require("plugin.lsp.tools.flutter-tools")
local java = require("java")
-- local cmake_setup = require("plugin.lsp.tools.cmake-tools")
local diagnostics = require("plugin.lsp.configs.lsp_diagnostics_configs")
local servers = require("plugin.lsp.configs.languages")
local lspconfig = require("lspconfig")
local lsp_utils = require("lspconfig.util")
local default_capabilities = require("plugin.lsp.configs.capabilities")
require("plugin.lsp.tools.none_ls")

--- setup all the LSP used by these configurations
function M.setup()
	local capabilities = default_capabilities.get_capabilities()
	M.config_lsp_langs(capabilities)
	diagnostics.setup_config()
	code_lens.setup()
	debugger.setup()
	flutter_setup.setup(capabilities)

	-- cmake_setup.setup()

	utils.create_autocmds()
	vim.lsp.enable(servers.languages)
	java.setup({
		jdk = {
			auto_install = true,
			version = "21",
			path = os.getenv('JAVA_HOME'),
		},
	})
	require("spring_boot").init_lsp_commands()
	require("plugin.colorizer")
end

function M.config_lsp_langs(capabilities)
	local jdtls_config = {
		bundles = {},
	}
	vim.list_extend(jdtls_config.bundles, require("spring_boot").java_extensions())
	vim.lsp.config("jdtls", {
		capabilities = capabilities,
		init_options = {
			bundles = require("spring_boot").java_extensions(),
		},
	})
	vim.lsp.config("tailwindcss", {
		capabilities = capabilities,
		on_attach = function(client, bufnr)
			if client.server_capabilities["documentSymbolProvider"] then
				require("nvim-navic").attach(client, bufnr)
			end
		end,
		settings = {
			tailwindCSS = {
				classAttributes = { "class", "className", "class:list", "classList", "ngClass" },
				lint = {
					cssConflict = "warning",
					invalidApply = "error",
					invalidConfigPath = "error",
					invalidScreen = "error",
					invalidTailwindDirective = "error",
					invalidVariant = "error",
					recommendedVariantOrder = "warning",
				},
				validate = true,
			},
		},
	})

	vim.lsp.config("yamlls", {
		capabilities = capabilities,
		on_attach = function(client, bufnr)
			client.server_capabilities.documentFormattingProvider = true
			if client.server_capabilities["documentSymbolProvider"] then
				require("nvim-navic").attach(client, bufnr)
			end
		end,
		settings = {
			yamlls = {
				format = {
					enable = true, -- Enable formatting
				},
				schemaStore = {
					-- You must disable built-in schemaStore support if you want to use
					-- this plugin and its advanced options like `ignore`.
					enable = false,
					-- Avoid TypeError: Cannot read properties of undefined (reading 'length')
					url = "",
				},
				schemas = require("schemastore").yaml.schemas(),
			},
		},
	})

	vim.lsp.config("rust_analyzer", {
		on_attach = function(client, bufnr)
			vim.lsp.inlay_hint.enable(true, { bufnr = bufnr })
			if client.server_capabilities["documentSymbolProvider"] then
				require("nvim-navic").attach(client, bufnr)
			end
		end,
		capabilities = capabilities,
		settings = {
			["rust-analyzer"] = {
				checkOnSave = { command = "clippy" },
				cargo = { allFeatures = true },
				procMacro = { enable = true },
				files = {
					exclude = { ".git", "target", "node_modules" },
					watcher = "client",
				},
			},
		},
	})

	vim.lsp.config("jsonls", {
		on_attach = function(client, bufnr)
			if client.server_capabilities["documentSymbolProvider"] then
				require("nvim-navic").attach(client, bufnr)
			end
		end,
		capabilities = capabilities,
		settings = {
			jsonls = {
				schemas = require("schemastore").json.schemas(),
				validate = { enable = true },
			},
		},
	})

	vim.lsp.config("lua_ls", {
		capabilities = capabilities,
		on_attach = function(client, bufnr)
			vim.lsp.inlay_hint.enable(true, { bufnr = bufnr })
		end,
		settings = {
			Lua = {
				runtime = { version = "LuaJIT" },
				diagnostics = { globals = { "vim" } },
				workspace = {
					library = vim.env.VIMRUNTIME,
					checkThirdParty = false,
				},
				hint = {
					enable = true,
					arrayIndex = "Enable",
					paramName = "All",
				},
				telemetry = { enable = false },
				codelens = {
					enable = true,
				},
			},
		},
	})

	vim.lsp.config("cssls", {
		on_attach = function(client, bufnr)
			vim.lsp.inlay_hint.enable(true, { bufnr = bufnr })
			if client.server_capabilities["documentSymbolProvider"] then
				require("nvim-navic").attach(client, bufnr)
			end
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

	vim.lsp.config("html", {
		capabilities = capabilities,
		on_attach = function(client, bufnr)
			if client.server_capabilities["documentSymbolProvider"] then
				require("nvim-navic").attach(client, bufnr)
			end
		end,
	})

	vim.lsp.config("dockerls", {
		capabilities = capabilities,
		on_attach = function(client, bufnr)
			if client.server_capabilities["documentSymbolProvider"] then
				require("nvim-navic").attach(client, bufnr)
			end
		end,
		settings = {
			docker = {
				languageserver = {
					formatter = {
						ignoreMultilineInstructions = true,
					},
				},
			},
		},
	})
end

M.hover_opts = {
	border = "rounded",
	max_width = 45,
	max_height = 20,
	anchor_bias = "below", --Determines where put the popup: | above | below | auto |
}

return {
	setup = M.setup,
	hover_opts = M.hover_opts,
}
