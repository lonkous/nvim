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
        local builtin = require('telescope.builtin')

        vim.keymap.set('n', '<C-p>', builtin.git_files)
        vim.keymap.set("i", "<C-c>", "<Esc>")
        vim.keymap.set('n', '<leader>of', builtin.oldfiles, { desc = '[S]earch Recent Files ("." for repeat)' })
        vim.keymap.set('n', '<C-f>', builtin.current_buffer_fuzzy_find)
        vim.keymap.set('n', '<space>fb',
            ":Telescope file_browser path=%:p:h select_buffer=true hidden=true<CR>",
            { noremap = true }
        )
        vim.keymap.set('n', '<space>f', builtin.live_grep)
        vim.keymap.set('n', '<space>fh', builtin.search_history)
        vim.keymap.set('n', '<space>off', function() builtin.find_files({ cwd = '~/odoo/' }) end)
        vim.keymap.set('n', '<space>ff', builtin.find_files)
        vim.keymap.set('n', '<space>gs', builtin.git_status)
        vim.keymap.set('n', '<space>gc', builtin.git_commits)
        vim.keymap.set('n', '<space>gb', builtin.git_branches)
        vim.keymap.set('n', '<space>od', function() builtin.live_grep({ cwd = '~/odoo/' }) end)
        vim.keymap.set('n', '<space>l', builtin.lsp_document_symbols)
        vim.keymap.set('n', '<space>or', builtin.resume)

        function PromptForFileTypeAndSearchPath(path)
            local filetype = vim.fn.input('Enter file type (e.g., js, lua): ')
            if filetype ~= '' then
                builtin.live_grep({
                    search_dirs = { path or '.' },
                    glob_pattern = '*.' .. filetype,
                    additional_args = function() return { "--hidden", "--follow" } end,
                })
            else
                builtin.live_grep({ search_dirs = { path or '.' } })
            end
        end

        function PromptForFileTypeAndSearch()
            local filetype = vim.fn.input('Enter file type (e.g., js, lua): ')
            if filetype ~= '' then
                builtin.live_grep({
                    glob_pattern = '*.' .. filetype,
                    additional_args = function() return { "--hidden", "--follow" } end,
                })
            else
                print("No file type provided. Search aborted.")
            end
        end

        vim.keymap.set('n', '<leader>e', PromptForFileTypeAndSearch)
        vim.keymap.set('n', '<leader>ep', PromptForFileTypeAndSearchPath)
        vim.keymap.set('n', '<leader>oe', function() PromptForFileTypeAndSearchPath('~/odoo/') end)
        vim.keymap.set('n', '<leader>el', function()
            local location = vim.fn.input('Enter location: ')
            PromptForFileTypeAndSearchPath(location)
        end)
        vim.keymap.set('n', '<leader>ec', function()
            local location = vim.fn.expand('%:p:h')
            PromptForFileTypeAndSearchPath(location)
        end)

        pcall(require('telescope').load_extension, 'fzf')
        pcall(require('telescope').load_extension, 'ui-select')

        telescope.setup({
            defaults = {
                vimgrep_arguments = {
                    "rg",
                    "--line-number",
                    "--column",
                    "--follow",
                    "--smart-case",
                    "--pcre2"
                },
                layout_strategy = "flex",
                layout_config = {
                    prompt_position = "top",
                },
                prompt_prefix = " ",
                selection_caret = " ",
                path_display = { "absolute" },
                sorting_strategy = 'ascending',
                mappings = {
                    i = {
                        ["<c-k>"] = actions.move_selection_previous,
                        ["<c-j>"] = actions.move_selection_next,
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
