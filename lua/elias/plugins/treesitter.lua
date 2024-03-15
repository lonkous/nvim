return
{
    "nvim-treesitter/nvim-treesitter",
    build = ":TSUpdate",
    config = function()
        local configs = require("nvim-treesitter.configs")

        configs.setup({
            ensure_installed = { "c", "lua", "vim", "vimdoc", "query", "elixir", "heex", "javascript", "html", "markdown" },
            sync_install = true,
            highlight = { enable = true },
            indent = { enable = true },
            smart_rename = { enable = true },
        })
    end
}
