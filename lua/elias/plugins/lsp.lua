return {
	{
		"neovim/nvim-lspconfig",
		event = { "BufReadPre", "BufNewFile" },
		dependencies = {
			"hrsh7th/cmp-nvim-lsp",
			{ "antosha417/nvim-lsp-file-operations", config = true },
		},
		config = function()
			-- import lspconfig plugin
			local lspconfig = require("lspconfig")

			-- import cmp-nvim-lsp plugin
			local cmp_nvim_lsp = require("cmp_nvim_lsp")

			local keymap = vim.keymap -- for conciseness

			local opts = { noremap = true, silent = true, auto = true }
			vim.api.nvim_create_autocmd("LspAttach", {
				group = vim.api.nvim_create_augroup("UserLspConfig", {}),
				callback = function(ev)
					-- Enable completion triggered by <c-x><c-o>
					vim.bo[ev.buf].omnifunc = "v:lua.vim.lsp.omnifunc"

					-- Buffer local mappings.
					-- See `:help vim.lsp.*` for documentation on any of the below functions
					local opts = { buffer = ev.buf }
					keymap.set("n", "gd", function()
						vim.lsp.buf.definition()
					end, opts)
					keymap.set("n", "gD", function()
						vim.lsp.buf.declaration()
					end, opts)
					keymap.set("n", "K", function()
						vim.lsp.buf.hover()
					end, opts)
					keymap.set("n", "<leader>vws", function()
						vim.lsp.buf.workspace_symbol()
					end, opts)
					keymap.set("n", "H", function()
						vim.diagnostic.open_float()
					end, opts)
					keymap.set("n", "[d", function()
						vim.diagnostic.goto_next()
					end, opts)
					keymap.set("n", "]d", function()
						vim.diagnostic.goto_prev()
					end, opts)
					keymap.set("n", "<leader>k", function()
						vim.lsp.buf.code_action()
					end, opts)
					keymap.set("n", "Q", function()
						vim.lsp.buf.code_action({
							only = { "quickfix" },
						})
					end, opts)
					keymap.set("n", "<leader>vrr", function()
						vim.lsp.buf.references()
					end, opts)
					keymap.set("n", "rn", function()
						vim.lsp.buf.rename()
					end, opts)
					keymap.set("i", "<C-h>", function()
						vim.lsp.buf.signature_help()
					end, opts)
				end,
			})
			local capabilities = cmp_nvim_lsp.default_capabilities()

			local signs = { Error = "✘", Warn = " ", Hint = "󰠠 ", Info = " " }
			local hl_groups = {
				[vim.diagnostic.severity.ERROR] = "LspDiagnosticsSignError",
				[vim.diagnostic.severity.WARN] = "LspDiagnosticsSignWarning",
				[vim.diagnostic.severity.HINT] = "LspDiagnosticsSignHint",
				[vim.diagnostic.severity.INFO] = "LspDiagnosticsSignInformation",
			}

			vim.diagnostic.config({
				signs = {
					text = {
						[vim.diagnostic.severity.ERROR] = signs.Error,
						[vim.diagnostic.severity.WARN] = signs.Warn,
						[vim.diagnostic.severity.HINT] = signs.Hint,
						[vim.diagnostic.severity.INFO] = signs.Info,
					},
					linehl = hl_groups,
					numhl = hl_groups,
				},
			})
			lspconfig.tsserver.setup({
				on_attach = function(client, bufnr)
					client.server_capabilities.documentFormattingProvider = false
				end,
			})
			lspconfig.lua.setup({
				on_attach = function(client, bufnr)
					client.server_capabilities.documentFormattingProvider = false
				end,
			})
		end,
	},
	{
		"jay-babu/mason-null-ls.nvim",
		event = { "BufReadPre", "BufNewFile" },
		dependencies = {
			"williamboman/mason.nvim",
			"nvimtools/none-ls.nvim",
			"nvimtools/none-ls-extras.nvim",
		},
		config = function()
			local null_ls = require("null-ls")

			require("mason-null-ls").setup({
				ensure_installed = { "stylua", "prettier", "eslint", "black", "jq" },
			})
			null_ls.setup({
				debug = true,
				sources = {
					null_ls.builtins.completion.spell,
					null_ls.builtins.formatting.prettier.with({
						filetypes = { "javascript", "typescript", "css", "html", "json", "yaml", "markdown" },
					}),
					null_ls.builtins.formatting.stylua.with({
						filetypes = { "lua" },
					}),
				},
			})
		end,
	},
	{
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
					"tsserver", --Typescript lsp
					"vimls", --Vimscript lsp
					"jsonls", --Json lsp
					"html", --Html lsp
					"cssls", --Css lsp
					"clangd", --C/C++ lsp
					"rust_analyzer", --Rust lsp
					"jdtls", --Java lsp
					"asm_lsp", --Assembly lsp
				},
				-- auto-install configured servers (with lspconfig)
				automatic_installation = true, -- not the same as ensure_installed
			})
			local lspconfig = require("lspconfig")
			local lsp_capabilities = require("cmp_nvim_lsp").default_capabilities()

			local lsp_attach = function(client, bufnr)
				-- Create your keybindings here...
			end

			require("mason-lspconfig").setup_handlers({
				function(server_name)
					lspconfig[server_name].setup({
						on_attach = lsp_attach,
						capabilities = lsp_capabilities,
					})
				end,
			})
		end,
	},
}
