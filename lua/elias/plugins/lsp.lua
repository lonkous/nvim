return {
	{
		"neovim/nvim-lspconfig",
		event = { "BufReadPre", "BufNewFile" },
		dependencies = {
			"saghen/blink.cmp",
			{ "antosha417/nvim-lsp-file-operations", config = true },
		},
		config = function()
			-- import lspconfig plugin
			local lspconfig = require("lspconfig")

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

			local signs = { Error = "✘", Warn = "", Hint = "󰠠 ", Info = " " }
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
			lspconfig.ts_ls.setup({
				on_attach = function(client, bufnr)
					client.server_capabilities.documentFormattingProvider = true
				end,
			})
			local home = os.getenv("HOME")
			local mason_pkg_path = home .. "/.local/share/nvim/mason/packages/jdtls"
			local launcher_path = vim.fn.glob(mason_pkg_path .. "/plugins/org.eclipse.equinox.launcher_*.jar")

			-- Use project-specific workspace
			local project_name = vim.fn.fnamemodify(vim.fn.getcwd(), ":p:h:t")
			local workspace_dir = home .. "/.local/share/nvim/jdtls-workspace/" .. project_name

			lspconfig.jdtls.setup({
				cmd = {
					"/usr/lib/jvm/java-21-openjdk-amd64/bin/java",
					"-Declipse.application=org.eclipse.jdt.ls.core.id1",
					"-Dosgi.bundles.defaultStartLevel=4",
					"-Declipse.product=org.eclipse.jdt.ls.core.product",
					"-Dlog.protocol=true",
					"-Dlog.level=ALL",
					"-Xms1g",
					"--add-modules=ALL-SYSTEM",
					"--add-opens",
					"java.base/java.util=ALL-UNNAMED",
					"--add-opens",
					"java.base/java.lang=ALL-UNNAMED",
					"-jar",
					launcher_path,
					"-configuration",
					mason_pkg_path .. "/config_linux",
					"-data",
					workspace_dir,
				},
				root_dir = lspconfig.util.root_pattern(".git", "mvnw", "gradlew"),
				settings = {
					java = {
						configuration = {
							runtimes = {
								{
									name = "JavaSE-17",
									path = "/usr/lib/jvm/java-17-openjdk-amd64",
									default = true,
								},
								{
									name = "JavaSE-21",
									path = "/usr/lib/jvm/java-21-openjdk-amd64",
								},
							},
						},
					},
				},
			})
		end,
	},
}
