return {
    { "lukas-reineke/indent-blankline.nvim" },
    { "echasnovski/mini.animate" },
    {
        "utilyre/barbecue.nvim",
        name = "barbecue",
        version = "*",
        dependencies = {
            "SmiteshP/nvim-navic",
            "nvim-tree/nvim-web-devicons",
        },
        opts = {
        },
    },
    {
        "folke/todo-comments.nvim",
        requires = "nvim-lua/plenary.nvim",
        config = function()
            require("todo-comments").setup({})
        end,
    },
    { "mbbill/undotree",
        vim.keymap.set("n", "<leader>u", vim.cmd.UndotreeToggle) },
    { "tpope/vim-fugitive" },
    {
        "windwp/nvim-autopairs",
        event = "InsertEnter",
        config = true,
        opts = {},
    },
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
    {
        "junegunn/fzf",
        build = "./install --bin"
    },
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
        "windwp/nvim-ts-autotag",
        config = function()
            require('nvim-ts-autotag').setup({
                opts = {
                    enable_close = true,
                    enable_rename = true,
                    enable_close_on_slash = false
                },
            })
        end
    },
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
