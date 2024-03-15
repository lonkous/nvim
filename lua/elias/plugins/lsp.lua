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
            vim.api.nvim_create_autocmd('LspAttach', {
                group = vim.api.nvim_create_augroup('UserLspConfig', {}),
                callback = function(ev)
                    -- Enable completion triggered by <c-x><c-o>
                    vim.bo[ev.buf].omnifunc = 'v:lua.vim.lsp.omnifunc'

                    -- Buffer local mappings.
                    -- See `:help vim.lsp.*` for documentation on any of the below functions
                    local opts = { buffer = ev.buf }
                    keymap.set("n", "gd", function() vim.lsp.buf.definition() end, opts)
                    keymap.set("n", "gD", function() vim.lsp.buf.declaration() end, opts)
                    keymap.set('n', 'K', function() vim.lsp.buf.hover() end, opts)
                    keymap.set("n", "<leader>vws", function() vim.lsp.buf.workspace_symbol() end, opts)
                    keymap.set("n", "H", function() vim.diagnostic.open_float() end, opts)
                    keymap.set("n", "[d", function() vim.diagnostic.goto_next() end, opts)
                    keymap.set("n", "]d", function() vim.diagnostic.goto_prev() end, opts)
                    keymap.set("n", "<leader>ca", function() vim.lsp.buf.code_action() end, opts)
                    keymap.set("n", "Q", function() vim.lsp.buf.quickfix() end, opts)
                    keymap.set("n", "<leader>vrr", function() vim.lsp.buf.references() end, opts)
                    keymap.set("n", "vrn", function() vim.lsp.buf.rename() end, opts)
                    keymap.set("i", "<C-h>", function() vim.lsp.buf.signature_help() end, opts)
                end,
            })
            -- used to enable autocompletion (assign to every lsp server config)
            local capabilities = cmp_nvim_lsp.default_capabilities()

            -- Change the Diagnostic symbols in the sign column (gutter)
            -- (not in youtube nvim video)
            local signs = { Error = "✘", Warn = " ", Hint = "󰠠 ", Info = " " }
            for type, icon in pairs(signs) do
                local hl = "DiagnosticSign" .. type
                vim.fn.sign_define(hl,
                    { text = icon, texthl = hl, numhl = "" })
                vim.cmd("highlight link " .. hl .. " LspDiagnosticsSign" .. type)
            end

            local odoo_root_dir = function(fname)
                return lspconfig.util.find_git_ancestor(fname) or
                    lspconfig.util.root_pattern('.odoo_lsp', '.odoo_lsp.json')(fname)
            end

            -- Setup for odoo-lsp
            lspconfig.odoo_lsp.setup {
                cmd = { 'odoo-lsp' },
                filetypes = { 'javascript', 'xml', 'python' },
                root_dir = odoo_root_dir,
                on_attach = function(client, bufnr)
                    -- Your on_attach function here, similar to what you've defined globally or custom for odoo-lsp
                end,
                capabilities = capabilities,
            }
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
                    "lua_ls",   --Lua ls
                    "pylsp",    --Python ls
                    "bashls",   --Bash ls
                    "tsserver", --Typescript ls
                    "lemminx",  --Lemminx ls
                    "vimls",    --Vimscript
                    "jsonls",   --Json ls
                    "html",     --Html lsp
                    "cssls",    --Css ls
                    "clangd",   --C/C++ ls
                },
                -- auto-install configured servers (with lspconfig)
                automatic_installation = true, -- not the same as ensure_installed
            })

            mason_lspconfig.setup_handlers {
                function(server_name) -- default handler (optional)
                    require("lspconfig")[server_name].setup {}
                end,
                function(server_name)
                    --
                    -- This function handles the setup for each server Mason manages
                    if server_name == "odoo_lsp" then
                        -- Custom setup for odoo-lsp
                        lspconfig.odoo_lsp.setup {
                            cmd = { 'odoo-lsp' },
                            filetypes = { 'javascript', 'xml', 'python' },
                            root_dir = root_dir,
                            -- Include any other necessary configurations here
                        }
                    else
                        -- Default handler for all other servers
                        lspconfig[server_name].setup {}
                    end
                end,
            }
        end,
    },
}
