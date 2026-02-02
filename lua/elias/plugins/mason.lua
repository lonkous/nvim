return {
	"williamboman/mason.nvim",
	dependencies = {
		"saghen/blink.cmp",
		"williamboman/mason-lspconfig.nvim",
		"WhoIsSethDaniel/mason-tool-installer.nvim",
	},
	config = function()
		-- import mason
		local mason = require("mason")

		-- import mason-lspconfig
		local mason_lspconfig = require("mason-lspconfig")

		-- enable mason and configure icons
		mason.setup({
			ui = {
				icons = {
					package_installed = "✓",
					package_pending = "➜",
					package_uninstalled = "✗",
				},
			},
		})

		local capabilities = vim.lsp.protocol.make_client_capabilities()
		capabilities = vim.tbl_deep_extend("force", capabilities, require("blink.cmp").get_lsp_capabilities())
		local servers = {
			bashls = {},
			clangd = {
				cmd = {
					"clangd",
				},
			},
			lua_ls = {
				settings = {
					Lua = {
						workspace = { checkThirdParty = false },
						telemetry = { enable = false },
						diagnostics = { globals = { "vim", "Snacks" } },
					},
				},
			},
			marksman = {},
			jdtls = {
				autostart = false,
			},
			jsonls = {},
			pylsp = {},
			sqlls = {},
			html = {},
			cssls = {},
			ts_ls = { },
			lemminx = {},
			vimls = {},
			rust_analyzer = {},
		}

		local ensure_installed = vim.tbl_keys(servers or {})
		vim.list_extend(ensure_installed, {
			"stylua", --Formater Lua
			"isort", --Formater Python
			"autopep8",
			"ts_ls",
		})
		require("mason-tool-installer").setup({ ensure_installed = ensure_installed })

		require("mason-lspconfig").setup({
			handlers = {
				function(server_name)
					if server_name ~= "jdtls" then
						local server = servers[server_name] or {}
						server.capabilities = vim.tbl_deep_extend("force", {}, capabilities, server.capabilities or {})
						require("lspconfig")[server_name].setup(server)
					end
				end,
			},
		})
	end,
}
