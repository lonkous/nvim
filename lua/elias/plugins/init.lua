return {
  { "lukas-reineke/indent-blankline.nvim" },
  { 'echasnovski/mini.animate' },
  {
    "utilyre/barbecue.nvim",
    name = "barbecue",
    version = "*",
    dependencies = {
      "SmiteshP/nvim-navic",
      "nvim-tree/nvim-web-devicons",       -- optional dependency
    },
    opts = {
      -- configurations go here
    },
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
  { 'HiPhish/nvim-ts-rainbow2' },
  {
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
  { 'voldikss/vim-floaterm' },
  { 'f-person/git-blame.nvim' },
  {
    "folke/which-key.nvim",
    config = function()
      vim.o.timeout = true
      vim.o.timeoutlen = 300
      require("which-key").setup {}
    end
  },
  {
    "ibhagwan/fzf-lua",
    -- optional for icon support
    dependencies = { "nvim-tree/nvim-web-devicons" },
    config = function()
      -- calling `setup` is optional for customization
      require("fzf-lua").setup({})
    end
  },
  { "windwp/nvim-ts-autotag" },
  { 'nvim-lua/plenary.nvim' },
  { 'nvim-pack/nvim-spectre',
    vim.keymap.set('n', '<leader>S', '<cmd>lua require("spectre").toggle()<CR>', {
      desc = "Toggle Spectre"
    }) }
  , {
  "j-hui/fidget.nvim",
  dependencies = { "rcarriga/nvim-notify" },
  opts = {},
},
  { 'farmergreg/vim-lastplace' }
  , {
  'rmagatti/auto-session',
  config = function()
    require("auto-session").setup {
      log_level = "error",
      auto_session_suppress_dirs = { "~/", "~/Projects", "~/Downloads", "/" },
    }
  end
},
  {
    "SirVer/ultisnips",
    config = function()
      local ls = require("luasnip")
      ls.add_snippets("javascript", {

        ls.parser.parse_snippet(
          "ccc",
          "console.log(${1:variable})"
        ),

      })
      ls.add_snippets("python", {
        ls.parser.parse_snippet(
          "lo",
          "_logger.info(${1})"
        )
      })
      ls.filetype_extend("typescriptreact", { "javascriptreact" })
      ls.filetype_extend("typescript", { "javascript" })
      ls.filetype_extend("javascript", { "html" })
      ls.filetype_extend("xml", { "html" })
      ls.filetype_extend("typescriptreact", { "javascript" })
    end
  },
  { "github/copilot.vim" },

}
