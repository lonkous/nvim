local lsp = require("lsp-zero").preset(
{
    "lua",
    "rust",
    "python",
    "bash",
    "java",
    "typescript",
    "typescriptreact",
    "javascript",
    "javascriptreact",
    "html",
    "css",
    "go",
    "php",
    "c",
    "cpp",
    "csharp",
    "kotlin",
    "vue",

})

lsp.ensure_installed({
    'tsserver',
    'rust_analyzer',
})
local kind_icons = {
    Text = "",
    Method = "",
    Function = "",
    Constructor = "",
    Field = "ﰠ",
    Variable = "",
    Class = "",
    Interface = "",
    Module = "",
    Property = "",
    Unit = "",
    Value = "",
    Enum = "",
    Keyword = "",
    Snippet = "",
    Color = "",
    File = "",
    Reference = "",
    Folder = "",
    EnumMember = "",
    Constant = "",
    Struct = "פּ",
    Event = "",
    Operator = "",
    TypeParameter = "",
}

-- Fix Undefined global 'vim'
lsp.configure('lua-language-server', {
    settings = {
        Lua = {
            diagnostics = {
                globals = { 'vim' }
            }
        }
    }
})
local cmp = require 'cmp'
cmp.setup {
    snippet = {
        expand = function(args)
            luasnip.lsp_expand(args.body)
        end,
    },
    sources = {
        { name = 'nvim_lsp' },
        { name = 'luasnip' },
        { name = 'path' },
    },
    -- sorting = {
        --     comparators = {
            --         compare.exact,
            --         compare.recently_used,
            --     },
            -- },
            mapping = cmp.mapping.preset.insert({
                ['<C-s>'] = cmp.mapping.select_prev_item(cmp_select),
                ['<C-n>'] = cmp.mapping.select_next_item(cmp_select),
                ['<C-y>'] = cmp.mapping.confirm({ select = true }),
                ['<CR>'] = cmp.mapping.confirm({
                    behavior = cmp.ConfirmBehavior.Replace,
                    select = true,
                }),
            }),
        }

        lsp.set_preferences({
            suggest_lsp_servers = false,
            sign_icons = {
                error = '',
                warn = '',
                info = '',
                hint = '',
            }
        })

        lsp.on_attach(function(client, bufnr)
            local opts = {buffer = bufnr, remap = false}

            vim.keymap.set("n", "gd", function() vim.lsp.buf.definition() end, opts)
            vim.keymap.set("n", "K", function() vim.lsp.buf.hover() end, opts)
            vim.keymap.set("n", "<leader>vws", function() vim.lsp.buf.workspace_symbol() end, opts)
            vim.keymap.set("n", "<leader>vd", function() vim.diagnostic.open_float() end, opts)
            vim.keymap.set("n", "[d", function() vim.diagnostic.goto_next() end, opts)
            vim.keymap.set("n", "]d", function() vim.diagnostic.goto_prev() end, opts)
            vim.keymap.set("n", "<leader>vca", function() vim.lsp.buf.code_action() end, opts)
            vim.keymap.set("n", "<leader>vrr", function() vim.lsp.buf.references() end, opts)
            vim.keymap.set("n", "<leader>vrn", function() vim.lsp.buf.rename() end, opts)
            vim.keymap.set("i", "<C-h>", function() vim.lsp.buf.signature_help() end, opts)
        end)
        local lspkind = require('lspkind')
        cmp.setup {
            formatting = {
                format = lspkind.cmp_format({
                    mode = 'symbol_text',  -- show only symbol annotations
                    maxwidth = 50,         -- prevent the popup from showing more than provided characters (e.g 50 will not show more than 50 characters)
                    ellipsis_char = '...', -- when popup menu exceed maxwidth, the truncated part would show ellipsis_char instead (must define maxwidth first)
                    before = function(entry, vim_item)
                        vim_item.kind = kind_icons[vim_item.kind] .. " |" .. vim_item.kind
                        return vim_item
                    end
                })
            }
        }

        lsp.setup()

        vim.diagnostic.config({
            virtual_text = true
        })


