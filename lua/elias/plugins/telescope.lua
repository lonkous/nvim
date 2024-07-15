return {
    "nvim-telescope/telescope.nvim",
    tag = "0.1.5",
    dependencies = {
        "nvim-telescope/telescope-file-browser.nvim",
        "nvim-lua/plenary.nvim",
        "nvim-tree/nvim-web-devicons",
        'nvim-telescope/telescope-ui-select.nvim'
    },
    config = function()
        local telescope = require("telescope")
        local actions = require("telescope.actions")
        local action_layout = require("telescope.actions.layout")

        builtin = require('telescope.builtin')
        vim.keymap.set('n', '<C-p>', ":FzfLua git_files<CR>")
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
            ":Telescope file_browser path=%:p:h select_buffer=true hidden=true<CR>",
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
            "<space>off",
            ":lua require'fzf-lua'.files({cwd='~/odoo/' })<CR>",
            { noremap = true }
        )
        vim.api.nvim_set_keymap(
            "n",
            "<space>ff",
            ":FzfLua files<CR>",
            { noremap = true }
        )

        vim.api.nvim_set_keymap(
            "n",
            "<space>gs",
            ":FzfLua git_status<CR>",
            { noremap = true }
        )

        vim.api.nvim_set_keymap(
            "n",
            "<space>gc",
            ":FzfLua git_commits<CR>",
            { noremap = true }
        )
        vim.api.nvim_set_keymap(
            "n",
            "<space>gb",
            ":FzfLua git_branches<CR>",
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
            "<space>l",
            ":FzfLua lsp_document_symbols<CR>",
            { noremap = true }
        )
        vim.api.nvim_set_keymap(
            "n",
            "<space>or",
            ":FzfLua resume<CR>",
            { noremap = true }
        )


        function PromptForFileTypeAndSearchPath(path)
            local filetype = vim.fn.input('Enter file type (e.g., js, lua): ')
            if filetype ~= '' then
                local rg_cmd =
                    "rg --column --color=always --no-heading --line-number --smart-case --hidden --stats --follow --glob '!{node_modules,.git}' -g '*." ..
                    filetype .. "'"
                require 'fzf-lua'.live_grep({
                    cmd = rg_cmd,
                    cwd = path or nil,
                    file_ignore_patterns = { 'bin', 'lib' }

                })
            else
                require 'fzf-lua'.live_grep({
                    cwd = path or nil,
                    file_ignore_patterns = { 'bin', 'lib' }

                })
            end
        end

        function PromptForFileTypeAndSearch()
            local filetype = vim.fn.input('Enter file type (e.g., js, lua): ')
            if filetype ~= '' then
                local rg_cmd = "rg --column --color=always -g '*." .. filetype .. "'"
                require 'fzf-lua'.live_grep({
                    cmd = rg_cmd,
                    file_ignore_patterns = { 'bin', 'lib' }
                })
            else
                print("No file type provided. Search aborted.")
            end
        end

        vim.api.nvim_set_keymap('n', '<leader>e', ":lua PromptForFileTypeAndSearch()<CR>",
            { noremap = true, silent = true })

        vim.api.nvim_set_keymap('n', '<leader>ep', ":lua PromptForFileTypeAndSearchPath()<CR>",
            { noremap = true, silent = true })


        vim.api.nvim_set_keymap('n', '<leader>oe', ":lua PromptForFileTypeAndSearchPath( '~/odoo/')<CR>",
            { noremap = true, silent = true })

        function PromptLocation()
            local location = vim.fn.input('Enter location: ')
            PromptForFileTypeAndSearchPath(location)
        end

        vim.api.nvim_set_keymap('n', '<leader>el', ":lua PromptLocation()<CR>",
            { noremap = true, silent = true })

        function CurrentLocation()
            local location = vim.fn.expand('%:p:h')
            PromptForFileTypeAndSearchPath(location)
        end

        vim.api.nvim_set_keymap('n', '<leader>ec', ":lua CurrentLocation()<CR>",
            { noremap = true, silent = true })

        telescope.setup({
            defaults = {
                vimgrep_arguments = {
                    "rg",
                    "--line-number",
                    "--column",
                    "--follow",
                    "--smart-case",
                },
                layout_strategy = "flex",

                prompt_prefix = " ",
                selection_caret = " ",
                path_display = { "smart" },
                generic_sorter = require('telescope.sorters').get_generic_fuzzy_sorter,
                file_sorter = require('telescope.sorters').get_fuzzy_file,
                color_devicons = true,


                file_previewer = require('telescope.previewers').vim_buffer_cat.new,
                grep_previewer = require('telescope.previewers').vim_buffer_vimgrep.new,
                qflist_previewer = require('telescope.previewers').vim_buffer_qflist.new,
                buffer_previewer_maker = require('telescope.previewers').buffer_previewer_make,
                use_less = true,
                set_env = { ["COLORTERM"] = "truecolor" },
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
                        ["<C-u>"] = false,
                        ["<M-p>"] = action_layout.toggle_preview
                    },
                    n = {
                        ["<M-p>"] = action_layout.toggle_preview
                    }
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
