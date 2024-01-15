local ensure_packer = function()
  local fn = vim.fn
  local install_path = fn.stdpath('data') .. '/site/pack/packer/start/packer.nvim'
  if fn.empty(fn.glob(install_path)) > 0 then
    fn.system({ 'git', 'clone', '--depth', '1', 'https://github.com/wbthomason/packer.nvim', install_path })
    vim.cmd [[packadd packer.nvim]]
    return true
  end
  return false
end

local packer_bootstrap = ensure_packer()
return require('packer').startup(function(use)
  -----------------------Base-----------------------



  use('wbthomason/packer.nvim')                                 -- package manager

  use('nvim-treesitter/nvim-treesitter', { run = ':TSUpdate' }) -- treesitter

  use('romgrk/nvim-treesitter-context')                         -- context

  use {
    "nvim-telescope/telescope-file-browser.nvim",
    requires = { "nvim-telescope/telescope.nvim", "nvim-lua/plenary.nvim" }
  }                                 -- file browser

  use('nvim-treesitter/playground') -- treesitter playground

  use {
    'nvim-telescope/telescope.nvim', tag = '0.1.1',
    requires = { { 'nvim-lua/plenary.nvim' } }
  } -- telescope


  ----------------------Themes----------------------


  use {
    "folke/tokyonight.nvim",
    lazy = false,
    priority = 1000,
    opts = {},
  }                                          -- color

  use("lukas-reineke/indent-blankline.nvim") -- indent line

  use {
    'nvim-tree/nvim-tree.lua',
    requires = {
      'nvim-tree/nvim-web-devicons', -- optional, for file icons
    },
    tag = 'nightly'
  } -- file tree
  require("nvim-tree").setup({
    sort_by = "case_sensitive",
    view = {
      width = 60
    },
    renderer = {
      group_empty = true,
    },
    filters = {
      dotfiles = true,
    },
  })

  use 'nvim-tree/nvim-web-devicons'

  use 'echasnovski/mini.animate'

  use({
    "utilyre/barbecue.nvim",
    tag = "*",
    requires = {
      "SmiteshP/nvim-navic",
      "nvim-tree/nvim-web-devicons", -- optional dependency
    },
    config = function()
      require("barbecue").setup()
    end,
  }) -- route to file

  use { 'akinsho/bufferline.nvim', tag = "*", requires = 'nvim-tree/nvim-web-devicons' }

  use {
    'nvim-lualine/lualine.nvim',
    requires = { 'nvim-tree/nvim-web-devicons', opt = false }
  } -- status line

  use { 'echasnovski/mini.indentscope' }

  use {
    'lewis6991/gitsigns.nvim',
  }

  use { 'dstein64/vim-startuptime' }


  ---------------------Tools---------------------


  use {
    "folke/todo-comments.nvim",
    requires = "nvim-lua/plenary.nvim",
    config = function()
      require("todo-comments").setup {
      }
    end
  }                               -- todo comments

  use('mbbill/undotree')          -- undo tree

  use('tpope/vim-fugitive')       -- git

  use('github/copilot.vim')       -- copilot

  use('RRethy/vim-illuminate')    -- highlight word under cursor

  use('HiPhish/nvim-ts-rainbow2') -- rainbow parentheses

  use {
    'numToStr/Comment.nvim',
    config = function()
      require('Comment').setup()
    end
  } -- comment with keybindings of gc gcc

  use {
    'laytan/tailwind-sorter.nvim',
    requires = { 'nvim-treesitter/nvim-treesitter', 'nvim-lua/plenary.nvim' },
    config = function() require('tailwind-sorter').setup() end,
    run = 'cd formatter && npm i && npm run build',
  } -- tailwind class sorter

  use {
    "windwp/nvim-autopairs",
    config = function() require("nvim-autopairs").setup {} end
  } -- auto pairs

  use {
    "folke/trouble.nvim",
    requires = "nvim-tree/nvim-web-devicons",
    config = function()
      require("trouble").setup {
        mode = "document_diagnostics",
      }
    end
  } -- shows errors
  use('j-hui/fidget.nvim')
  require "fidget".setup {}

  use('onsails/lspkind-nvim')
  use({
    "iamcco/markdown-preview.nvim",
    run = function() vim.fn["mkdp#util#install"]() end,
  })

  use("ethanholz/nvim-lastplace")

  use("onsails/lspkind.nvim")

  use {
    "danymat/neogen",
    config = function()
      require('neogen').setup {}
    end,
    requires = "nvim-treesitter/nvim-treesitter",
    -- Uncomment next line if you want to follow only stable versions
    -- tag = "*"
  }
  use {
    'rmagatti/auto-session',
    config = function()
      require("auto-session").setup {
        log_level = "error",
        auto_session_suppress_dirs = { "~/", "~/Projects", "~/Downloads", "/" },
      }
    end
  }

  use 'voldikss/vim-floaterm'

  use 'f-person/git-blame.nvim'

  use {
    'phaazon/hop.nvim',
    branch = 'v2',
    config = function()
      require 'hop'.setup {}
    end
  }

  use { 'SirVer/ultisnips' }


  ------------------Help---------------------


  use {
    "folke/which-key.nvim",
    config = function()
      vim.o.timeout = true
      vim.o.timeoutlen = 300
      require("which-key").setup {}
    end
  } -- shows keybindings

  ------------------Git---------------------


  use { 'sindrets/diffview.nvim', requires = 'nvim-lua/plenary.nvim' } --Diffview


  ------------------LSP---------------------


  use {
    'VonHeikemen/lsp-zero.nvim',
    branch = 'v3.x',
    requires = {
      -- LSP Support
      { 'neovim/nvim-lspconfig' },             -- Required
      { 'williamboman/mason.nvim' },           -- Optional
      { 'williamboman/mason-lspconfig.nvim' }, -- Optional

      -- Autocompletion
      { 'hrsh7th/nvim-cmp' },
      { 'hrsh7th/cmp-nvim-lsp' },
      { 'hrsh7th/cmp-buffer' },
      { 'hrsh7th/cmp-path' },
      { 'saadparwaiz1/cmp_luasnip' },
      { 'hrsh7th/cmp-nvim-lua' },
      { 'L3MON4D3/LuaSnip' },
      { 'rafamadriz/friendly-snippets' },
    }
  }
  if packer_bootstrap then
    require('packer').sync()
  end
end)
