vim.g.mapleader = " "
--move highlighted stuff up and down
vim.keymap.set("v", "<C-J>", ":m '>+1<CR>gv=gv")
vim.keymap.set("v", "<C-K>", ":m '<-2<CR>gv=gv")
vim.keymap.set("n", "J", "mzJ`z")
--jump up and down
vim.keymap.set("x", "<leader>p", [["_dP]])
--replace current word
vim.keymap.set("n", "<leader>s", [[:%s/\<<C-r><C-w>\>/<C-r><C-w>/gI<Left><Left><Left>]])
vim.keymap.set("n", "<C-h>", "^")
-- Jump to the end of the line
vim.keymap.set("n", "<C-l>", "$")
vim.keymap.set("n", "<C-d>", "<Cmd>t.<CR>")
--window managing
vim.keymap.set("n", "<A-1>", "<Cmd>BufferLineGoToBuffer 1<CR>")
vim.keymap.set("n", "<A-2>", "<Cmd>BufferLineGoToBuffer 2<CR>")
vim.keymap.set("n", "<A-3>", "<Cmd>BufferLineGoToBuffer 3<CR>")
vim.keymap.set("n", "<A-4>", "<Cmd>BufferLineGoToBuffer 4<CR>")
vim.keymap.set("n", "<A-5>", "<Cmd>BufferLineGoToBuffer 5<CR>")
vim.keymap.set("n", "<A-6>", "<Cmd>BufferLineGoToBuffer 6<CR>")
vim.keymap.set("n", "<A-7>", "<Cmd>BufferLineGoToBuffer 7<CR>")
vim.keymap.set("n", "<A-8>", "<Cmd>BufferLineGoToBuffer 8<CR>")
vim.keymap.set("n", "<A-9>", "<Cmd>BufferLineGoToBuffer 9<CR>")
vim.keymap.set("n", "<A-w>", "<Cmd>bdelete<CR>")
vim.keymap.set("n", "<A-q>", "<Cmd>q<CR>")
vim.keymap.set("n", "<C-s>", "<Cmd>w<CR>")
vim.keymap.set("n", "<leader>G", ":LazyGit<CR>")
-- vim.keymap.set("n", "<A-f>", ":lua vim.lsp.buf.format()") -- readd in <CR>
vim.keymap.set("v", "<leader>c", '"+y')
vim.keymap.set("v", "<C-S-V>", '"+p')
vim.keymap.set('n', '<Esc>', '<cmd>nohlsearch<CR>')
