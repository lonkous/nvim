return {
	{
		"neovim/nvim-lspconfig",
		event = { "BufReadPre", "BufNewFile" },
		build = "cargo build --release",
		dependencies = {
			"saghen/blink.cmp",
			{ "antosha417/nvim-lsp-file-operations", config = true },
		},
		config = function()
			-- import lspconfig plugin
			require("mason").setup({
				ui = {
					icons = {
						package_installed = " ",
						package_pending = " ",
						package_uninstalled = " ",
					},
				},
			})

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
			vim.diagnostic.config({
				virtual_text = {
					prefix = "", -- Could be '●', '▎', │, 'x', '■', , 
				},
				jump = {
					float = true,
				},
				float = { border = "single" },
				signs = {
					text = {
						[vim.diagnostic.severity.ERROR] = " ",
						[vim.diagnostic.severity.WARN] = " ",
						[vim.diagnostic.severity.HINT] = "󰌶 ",
						[vim.diagnostic.severity.INFO] = " ",
					},
					numhl = {
						[vim.diagnostic.severity.ERROR] = "DiagnosticSignError",
						[vim.diagnostic.severity.WARN] = "DiagnosticSignWarn",
						[vim.diagnostic.severity.HINT] = "DiagnosticSignHint",
						[vim.diagnostic.severity.INFO] = "DiagnosticSignInfo",
					},
				},
			})

			local home = os.getenv("HOME")
			local mason_pkg_path = home .. "/.local/share/nvim/mason/packages/jdtls"
			local launcher_path = vim.fn.glob(mason_pkg_path .. "/plugins/org.eclipse.equinox.launcher_*.jar")

			-- Use project-specific workspace
			local project_name = vim.fn.fnamemodify(vim.fn.getcwd(), ":p:h:t")
			local workspace_dir = home .. "/.local/share/nvim/jdtls-workspace/" .. project_name

			-- Configure the jdtls server
			vim.lsp.config("jdtls", {
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
					launcher_path, -- Ensure this variable is defined
					"-configuration",
					mason_pkg_path .. "/config_linux", -- Ensure this variable is defined
					"-data",
					workspace_dir, -- Ensure this variable is defined
				},
				-- Correct way to specify root directory in the new API
				root_dir = vim.fs.dirname(vim.fs.find({ ".git", "mvnw", "gradlew", "pom.xml" }, { upward = true })[1]),
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
