return {
  { "lukas-reineke/indent-blankline.nvim" },
  { 'echasnovski/mini.animate' },
  {
    "utilyre/barbecue.nvim",
    name = "barbecue",
    version = "*",
    dependencies = {
      "SmiteshP/nvim-navic",
      "nvim-tree/nvim-web-devicons", -- optional dependency
    },
    opts = {
      -- configurations go here
    },
  },
  {
    'nvim-lualine/lualine.nvim',
    requires = { 'nvim-tree/nvim-web-devicons', opt = false }
  },
  { 'echasnovski/mini.indentscope' },
  {
    "folke/todo-comments.nvim",
    requires = "nvim-lua/plenary.nvim",
    config = function()
      require("todo-comments").setup {
      }
    end
  },
  { 'mbbill/undotree',
    vim.keymap.set('n', '<leader>u', vim.cmd.UndotreeToggle) },
  { 'tpope/vim-fugitive' },
  { 'github/copilot.vim' },
  { 'HiPhish/nvim-ts-rainbow2' }, {
  "windwp/nvim-autopairs",
  config = function() require("nvim-autopairs").setup {} end
},
  {
    "folke/trouble.nvim",
    requires = "nvim-tree/nvim-web-devicons",
    config = function()
      require("trouble").setup {
        mode = "document_diagnostics",
      }
    end
  },
  { "j-hui/fidget.nvim" },
  { "ethanholz/nvim-lastplace" },
  { 'voldikss/vim-floaterm' },
  { 'f-person/git-blame.nvim' },
  {
    "folke/which-key.nvim",
    config = function()
      vim.o.timeout = true
      vim.o.timeoutlen = 300
      require("which-key").setup {}
    end
  }
}
