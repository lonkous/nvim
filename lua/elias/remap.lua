--makes leader to be space
vim.g.mapleader = " "
--move highlighted stuff up and down
vim.keymap.set("v", "<C-J>", ":m '>+1<CR>gv=gv")
vim.keymap.set("v", "<C-K>", ":m '<-2<CR>gv=gv")
vim.keymap.set("v", "<C-K>", ":m '<-2<CR>gv=gv")
vim.keymap.set("n", "J", "mzJ`z")
--jump up and down
vim.keymap.set("x", "<leader>p", [["_dP]])
--replace current word
vim.keymap.set("n", "<leader>s", [[:%s/\<<C-r><C-w>\>/<C-r><C-w>/gI<Left><Left><Left>]])
vim.keymap.set("n", "<C-h>", "^")
-- Jump to the end of the line
vim.keymap.set("n", "<C-l>", "$")
vim.keymap.set("n", "<C-d>", '<Cmd>t.<CR>')
-- Jump to the end of the page
vim.keymap.set("n", "<C-k>", "<C-u>zz")
-- Jump to the beginning of the page
vim.keymap.set("n", "<C-j>", "<C-d>zz")
--window managing
vim.keymap.set('n', '<A-1>', '<Cmd>BufferLineGoToBuffer 1<CR>')
vim.keymap.set('n', '<A-2>', '<Cmd>BufferLineGoToBuffer 2<CR>')
vim.keymap.set('n', '<A-3>', '<Cmd>BufferLineGoToBuffer 3<CR>')
vim.keymap.set('n', '<A-4>', '<Cmd>BufferLineGoToBuffer 4<CR>')
vim.keymap.set('n', '<A-5>', '<Cmd>BufferLineGoToBuffer 5<CR>')
vim.keymap.set('n', '<A-6>', '<Cmd>BufferLineGoToBuffer 6<CR>')
vim.keymap.set('n', '<A-7>', '<Cmd>BufferLineGoToBuffer 7<CR>')
vim.keymap.set('n', '<A-8>', '<Cmd>BufferLineGoToBuffer 8<CR>')
vim.keymap.set('n', '<A-9>', '<Cmd>BufferLineGoToBuffer 9<CR>')
vim.keymap.set('n', '<C-t>', '<Cmd>enew<CR>')
vim.keymap.set('n', '<A-w>', '<Cmd>bdelete<CR>')
vim.keymap.set('n', '<A-q>', '<Cmd>q<CR>')
vim.keymap.set("n", "<leader>b", vim.cmd.NvimTreeToggle)
vim.keymap.set("n", "<C-s>", vim.cmd.w)
vim.keymap.set("n", "<leader>sp", '<Cmd>so <CR> <Cmd>PackerSync<CR>')
