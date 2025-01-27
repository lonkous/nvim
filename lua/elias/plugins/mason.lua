return {
		"williamboman/mason.nvim",
		dependencies = {
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

			mason_lspconfig.setup({
				-- list of servers for mason to install
				ensure_installed = {
					"lua_ls", --Lua lsp
					"pylsp", --Python lsp
					"bashls", --Bash lsp
					"ts_ls", --Typescript lsp
					"vimls", --Vimscript lsp
					"jsonls", --Json lsp
					"html", --Html lsp
					"cssls", --Css lsp
					"clangd", --C/C++ lsp
					"rust_analyzer", --Rust lsp
					"lemminx", --XML lsp
					"jdtls", --Java lsp
				},
				-- auto-install configured servers (with lspconfig)
				automatic_installation = true, -- not the same as ensure_installed
			})
			local lspconfig = require("lspconfig")
			local lsp_capabilities = require("cmp_nvim_lsp").default_capabilities()

			require("mason-lspconfig").setup_handlers({
				function(server_name)
					lspconfig[server_name].setup({
						on_attach = lsp_attach,
						capabilities = lsp_capabilities,
					})
				end,
			})
		end,
	}
