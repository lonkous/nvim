return {
    "nvim-telescope/telescope.nvim",
    tag = "0.1.5",
    dependencies = {
        "nvim-telescope/telescope-file-browser.nvim",
        "nvim-lua/plenary.nvim",
        "nvim-tree/nvim-web-devicons",
    },
    config = function()
        local telescope = require("telescope")
        local actions = require("telescope.actions")

        builtin = require('telescope.builtin')
        vim.keymap.set('n', '<C-p>', builtin.git_files, {})
        vim.keymap.set("i", "<C-c>", "<Esc>")
        vim.keymap.set("n", "<leader>of", "<Cmd>Telescope oldfiles<CR>")

        vim.api.nvim_set_keymap(
            "n",
            "<C-f>",
            ":FzfLua lgrep_curbuf<CR>",
            { noremap = true }
        )
        vim.api.nvim_set_keymap(
            "n",
            "<space>fb",
            ":Telescope file_browser path=%:p:h select_buffer=true<CR>",
            { noremap = true }
        )

        vim.api.nvim_set_keymap(
            "n",
            "<space>f",
            ":FzfLua live_grep search_dirs=. hidden=true<CR>",
            { noremap = true }
        )

        vim.api.nvim_set_keymap(
            "n",
            "<space>fh",
            ":Telescope search_history<CR>",
            { noremap = true }
        )
        vim.api.nvim_set_keymap(
            "n",
            "<space>B",
            ":Telescope git_branches<CR>",
            { noremap = true }
        )

        vim.api.nvim_set_keymap(
            "n",
            "<space>ff",
            ":Telescope find_files path=%:p:h <CR>",
            { noremap = true }
        )

        vim.api.nvim_set_keymap(
            "n",
            "<space>gs",
            ":Telescope git_status<CR>",
            { noremap = true }
        )

        vim.api.nvim_set_keymap(
            "n",
            "<space>gc",
            ":Telescope git_commits<CR>",
            { noremap = true }
        )
        vim.api.nvim_set_keymap(
            "n",
            "<space>gb",
            ":Telescope git_branches<CR>",
            { noremap = true }
        )

        vim.api.nvim_set_keymap(
            "n",
            "<space>od",
            ":lua require'fzf-lua'.live_grep({cwd='~/odoo/' })<CR>",
            { noremap = true }
        )
        vim.api.nvim_set_keymap(
            "n",
            "<space>op",
            ":lua require'fzf-lua'.live_grep({ cmd = 'rg --column --color=always -g \"*.py\"', cwd = '~/odoo/' })<CR>",
            { noremap = true }
        )
        vim.api.nvim_set_keymap(
            "n",
            "<space>ox",
            ":lua require'fzf-lua'.live_grep({ cmd = 'rg --column --color=always -g \"*.xml\"', cwd = '~/odoo/' })<CR>",
            { noremap = true }
        )



        telescope.setup({
            defaults = {
                layout_strategy = "flex",
                layout_config = {
                    vertical = {
                        prompt_position = 'top',
                        mirror = true,
                    },
                    horizontal = {
                        prompt_position = 'top',
                        mirror = false,
                    }
                },
                sorting_strategy = 'ascending',
                path_display = { "truncate " },
                mappings = {
                    i = {
                        ["<c-k>"] = actions.move_selection_previous, -- move to prev result
                        ["<c-j>"] = actions.move_selection_next,     -- move to next result
                        ["<c-q>"] = actions.send_selected_to_qflist + actions.open_qflist,
                    },
                },
            },
            extensions = {
                file_browser = {
                    hijack_netrw = true,
                },
            },
        })
    end,
}
