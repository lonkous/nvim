builtin = require('telescope.builtin')
vim.keymap.set('n', '<C-p>', builtin.git_files, {})
vim.keymap.set('n', '<C-f>', '<Cmd>Telescope current_buffer_fuzzy_find<CR>')
vim.keymap.set("i", "<C-c>", "<Esc>")
vim.keymap.set("n", "<leader>of", "<Cmd>Telescope oldfiles<CR>")

vim.api.nvim_set_keymap(
"n",
"<space>fb",
":Telescope file_browser path=%:p:h select_buffer=true<CR>",
{ noremap = true }
)

vim.api.nvim_set_keymap(
"n",
"<space>f",
":Telescope live_grep search_dirs=. hidden=true<CR>",
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
"<space>af",
":Telescope find_files search_dirs=. <CR>",
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
":Telescope live_grep search_dirs=~/odoo/<CR>",
{ noremap = true }
)


require("telescope").setup {
    defaults = {
        file_sorter = require('telescope.sorters').get_fuzzy_file,
    file_ignore_patterns = {},
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
        sorting_strategy = "ascending",
    },
    file_browser = {
    sorter = require('telescope.sorters').get_fzy_sorter,
  },
}

