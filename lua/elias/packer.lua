-- This file can be loaded by calling `lua require('plugins')` from your init.vim

-- Only required if you have packer configured as `opt`
vim.cmd [[packadd packer.nvim]]

return require('packer').startup(function(use)
  -- Packer can manage itself
  use 'wbthomason/packer.nvim'
  use {
	  'nvim-telescope/telescope.nvim', tag = '0.1.1',
	  -- or                            , branch = '0.1.x',
	  requires = { {'nvim-lua/plenary.nvim'} }
  }
  use { 
	  "catppuccin/nvim",
	  as ="catppuccin",
	  config = function()
		  vim.cmd.colorscheme 'catppuccin-frappe'
	  end,
  }
  use( 'nvim-treesitter/nvim-treesitter', {run = ':TSUpdate'})
  use('prettier/vim-prettier')
  
vim.api.nvim_create_autocmd('BufWritePost', {
  pattern = {"*.js","*.ts", "*.jsx","*.tsx"},
  callback = function()
    vim.cmd('Prettier')
  end,
})
  use ('nvim-treesitter/playground')  
  use('theprimeagen/harpoon')
  use('mbbill/undotree')
  use('tpope/vim-fugitive')
  --lines
 use ("lukas-reineke/indent-blankline.nvim") 
 --tailwind snippets
 use('iamcco/coc-tailwindcss')
 use('github/copilot.vim')
 --taskbar
 use('vim-airline/vim-airline')
 use('vim-airline/vim-airline-themes')
 use('frazrepo/vim-rainbow')
 
use {
    'laytan/tailwind-sorter.nvim',
    requires = {'nvim-treesitter/nvim-treesitter', 'nvim-lua/plenary.nvim'},
    config = function() require('tailwind-sorter').setup() end,
    run = 'cd formatter && npm i && npm run build',
  }
use{
  'nvim-tree/nvim-tree.lua',
  requires = {
    'nvim-tree/nvim-web-devicons', -- optional, for file icons
  },
  tag = 'nightly' -- optional, updated every week. (see issue #1193)
}
use {'dsznajder/vscode-es7-javascript-react-snippets',
run = 'yarn install --frozen-lockfile && yarn compile'
}
 use 'nvim-tree/nvim-web-devicons'
use {'romgrk/barbar.nvim', requires = 'nvim-web-devicons'}
 use {
  "folke/trouble.nvim",
  requires = "nvim-tree/nvim-web-devicons",
  config = function()
    require("trouble").setup {
    }
  end
}
 use {
	"windwp/nvim-autopairs",
    config = function() require("nvim-autopairs").setup {} end
}
  use {
	  'VonHeikemen/lsp-zero.nvim',
	  branch = 'v1.x',
	  requires = {
		  -- LSP Support
		  {'neovim/nvim-lspconfig'},             -- Required
		  {'williamboman/mason.nvim'},           -- Optional
		  {'williamboman/mason-lspconfig.nvim'}, -- Optional

		  -- Autocompletion
		  {'hrsh7th/nvim-cmp'},         -- Required
		  {'hrsh7th/cmp-nvim-lsp'},     -- Required
		  {'hrsh7th/cmp-buffer'},       -- Optional
		  {'hrsh7th/cmp-path'},         -- Optional
		  {'saadparwaiz1/cmp_luasnip'}, -- Optional
		  {'hrsh7th/cmp-nvim-lua'},     -- Optional

		  -- Snippets
		  {'L3MON4D3/LuaSnip'},             -- Required
		  {'rafamadriz/friendly-snippets'}, -- Optional
	  }
  }
  end)