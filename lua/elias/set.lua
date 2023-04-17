 
vim.opt.nu = true

vim.opt.relativenumber = true

vim.opt.tabstop = 4

vim.opt.wrap = false

vim.opt.shiftwidth = 4

vim.opt.softtabstop = 4

vim.opt.expandtab = true

vim.opt.undofile = true

vim.opt.incsearch = true

vim.opt.scrolloff = 10 

vim.opt.hlsearch = false

vim.opt.smartindent = true

vim.opt.swapfile = false

vim.opt.backup = false

vim.opt.undofile = true

vim.opt.signcolumn = "yes"

vim.opt.updatetime = 50

vim.api.nvim_create_autocmd('BufWritePost', {
  pattern = {"*.js","*.ts", "*.jsx","*.tsx"},
  callback = function()
    vim.cmd('Prettier')
  end,
})
vim.opt.spelllang = "en"
vim.opt.spell = true
