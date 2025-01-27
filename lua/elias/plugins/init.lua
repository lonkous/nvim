return {
    { "lukas-reineke/indent-blankline.nvim" },
    { "echasnovski/mini.animate" },
    {
        "utilyre/barbecue.nvim",
        name = "barbecue",
        version = "*",
        dependencies = {
            "SmiteshP/nvim-navic",
            "nvim-tree/nvim-web-devicons", -- optional dependency
        },
        opts = {
            -- configurations go here
        },
    },
    { "echasnovski/mini.indentscope" },
    {
        "folke/todo-comments.nvim",
        requires = "nvim-lua/plenary.nvim",
        config = function()
            require("todo-comments").setup({})
        end,
    },
    { "mbbill/undotree",             vim.keymap.set("n", "<leader>u", vim.cmd.UndotreeToggle) },
    { "tpope/vim-fugitive" },
    { "HiPhish/nvim-ts-rainbow2" },
    {
        "windwp/nvim-autopairs",
        event = "InsertEnter",
        config = true,
        opts = {},
    },
    {
        "folke/trouble.nvim",
        requires = "nvim-tree/nvim-web-devicons",
        config = function()
            require("trouble").setup({
                mode = "document_diagnostics",
            })
        end,
    },
    { "j-hui/fidget.nvim" },
    {
        "kdheepak/lazygit.nvim",
        cmd = {
            "LazyGit",
            "LazyGitConfig",
            "LazyGitCurrentFile",
            "LazyGitFilter",
            "LazyGitFilterCurrentFile",
        },
        -- optional for floating window border decoration
        dependencies = {
            "nvim-lua/plenary.nvim",
        },
    },
    { "f-person/git-blame.nvim" },
    {
        "folke/which-key.nvim",
        config = function()
            vim.o.timeout = true
            vim.o.timeoutlen = 300
            require("which-key").setup({})
        end,
    },
    { "junegunn/fzf",         build = "./install --bin" },
    {
        "ibhagwan/fzf-lua",
        -- optional for icon support
        dependencies = { "nvim-tree/nvim-web-devicons" },
        config = function()
            -- calling `setup` is optional for customization
            require("fzf-lua").setup({
                grep = {
                    -- Using ripgrep with forced color output
                    prompt = "🔎",
                    grep_opts = "--color=always --line-number --column --no-heading",
                    border = "rounded",
                    wrap = "nowrap",
                    layout = "flex",
                },
            })
        end,
    },
    { "nvim-lua/plenary.nvim" },
    {
        "j-hui/fidget.nvim",
        dependencies = { "rcarriga/nvim-notify" },
        opts = {},
    },
    { "farmergreg/vim-lastplace" },
    {
        "rmagatti/auto-session",
        config = function()
            require("auto-session").setup({
                log_level = "error",
                auto_session_suppress_dirs = { "~/", "~/Projects", "~/Downloads", "/" },
            })
        end,
    },
    {
        "SirVer/ultisnips",
        config = function()
            local ls = require("luasnip")
            ls.add_snippets("java", {

                ls.parser.parse_snippet("lo", "log.info(${1})"),
            })
            ls.add_snippets("javascript", {

                ls.parser.parse_snippet("cc", "console.log(${1})"),
            })
            ls.add_snippets("python", {
                ls.parser.parse_snippet("lo", "_logger.info(${1})"),
            })
            ls.filetype_extend("typescriptreact", { "javascriptreact" })
            ls.filetype_extend("typescript", { "javascript" })
            ls.filetype_extend("javascript", { "html" })
            ls.filetype_extend("htmlangular", { "html" })
            ls.filetype_extend("xml", { "html" })
            ls.filetype_extend("typescriptreact", { "javascript" })
        end,
    },
    { "github/copilot.vim" },
    { "romgrk/nvim-treesitter-context" },
    { "nvim-treesitter/nvim-treesitter-textobjects" },
    { "RRethy/vim-illuminate" },
    {
        "zbirenbaum/neodim",
        event = "LspAttach",
        config = function()
            require("neodim").setup({
                refresh_delay = 75,
                alpha = 0.50,
                blend_color = "#10171f",
                hide = {
                    underline = true,
                    virtual_text = true,
                    signs = true,
                },
                regex = {
                    "[uU]nused",
                    "[nN]ever [rR]ead",
                    "[nN]ot [rR]ead",
                },
                priority = 128,
                disable = {},
            })
        end,
    },
    {
        "karb94/neoscroll.nvim",
        config = function()
            neoscroll = require("neoscroll")
            local keymap = {
                ["<C-k>"] = function()
                    neoscroll.scroll(-50, {
                        move_cursor = true,
                        duration = 150,
                        easing = "easeInOutQuint",
                    })
                end,
                ["<C-j>"] = function()
                    neoscroll.scroll(50, {
                        move_cursor = true,
                        duration = 150,
                        easing = "easeInOutQuint",
                    })
                end,
            }
            local modes = { "n", "v", "x" }
            for key, func in pairs(keymap) do
                vim.keymap.set(modes, key, func)
            end
        end,
    },
    { "windwp/nvim-ts-autotag" },
    {
        "brenoprata10/nvim-highlight-colors",
        config = function()
            require("nvim-highlight-colors").setup({
                render = "background",
                enable_tailwind = true,
            })
        end,
    },

}
