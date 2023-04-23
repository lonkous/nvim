builtin = require('telescope.builtin')
vim.keymap.set('n', '<C-p>', builtin.git_files, {})
vim.keymap.set('n', '<C-f>', '<Cmd>Telescope current_buffer_fuzzy_find<CR>')
vim.keymap.set("i", "<C-c>", "<Esc>")
vim.keymap.set("n", "<leader>of", "<Cmd>Telescope oldfiles<CR>")
vim.api.nvim_set_keymap(
"n",
"<space>fb",
":Telescope file_browser",
{ noremap = true }
)

vim.api.nvim_set_keymap(
"n",
"<space>fb",
":Telescope file_browser path=%:p:h select_buffer=true<CR>",
{ noremap = true }
)

require("telescope").setup {
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
        sorting_strategy = "ascending",
    },
}
