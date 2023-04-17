vim.cmd [[packadd packer.nvim]]
return require('packer').startup(function(use)
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
    use ('romgrk/nvim-treesitter-context')
    use('prettier/vim-prettier')
    vim.api.nvim_create_autocmd('BufWritePost', {
        pattern = {"*.js","*.ts", "*.jsx","*.tsx"},
        callback = function()
            vim.cmd('Prettier')
        end,
    })
    use {
        "startup-nvim/startup.nvim",
        requires = {"nvim-telescope/telescope.nvim", "nvim-lua/plenary.nvim"},
    } 
    use {
        "nvim-telescope/telescope-file-browser.nvim",
        requires = { "nvim-telescope/telescope.nvim", "nvim-lua/plenary.nvim" }
    }
    use ('nvim-treesitter/playground')  
    use ('junegunn/rainbow_parentheses.vim')
    use {
        "folke/which-key.nvim",
        config = function()
            vim.o.timeout = true
            vim.o.timeoutlen = 300
            require("which-key").setup {
                -- refer to the configuration section below
            }
        end
    }
    use {
        "folke/todo-comments.nvim",
        requires = "nvim-lua/plenary.nvim",
        config = function()
            require("todo-comments").setup {
            }
        end
    }
    use('theprimeagen/harpoon')
    use('mbbill/undotree')
    use('tpope/vim-fugitive')
    --lines
    use ("lukas-reineke/indent-blankline.nvim") 
    --tailwind snippets

    use('github/copilot.vim')
   --  use('vim-airline/vim-airline')
   --  use('vim-airline/vim-airline-themes')
    use {
        'nvim-lualine/lualine.nvim',
        requires = { 'nvim-tree/nvim-web-devicons', opt = true }
   }
 require('lualine').setup {
  options = {
    icons_enabled = true,
    theme = 'auto',
    section_separators = { left = '', right = '' },
  component_separators = { left = '', right = '' },
    disabled_filetypes = {
      statusline = {},
      winbar = {},
    },
    ignore_focus = {},
    always_divide_middle = true,
    globalstatus = false,
    refresh = {
      statusline = 1000,
      tabline = 1000,
      winbar = 1000,
    }
  },
  sections = {
    lualine_a = {'mode'},
    lualine_b = {'branch',},
    lualine_c = {'filename'},
    lualine_x = {'encoding', 'fileformat', 'filetype'},
    lualine_y = {'progress'},
    lualine_z = {'location'}
  },
  inactive_sections = {
    lualine_a = {},
    lualine_b = {},
    lualine_c = {'filename'},
    lualine_x = {'location'},
    lualine_y = {},
    lualine_z = {}
  },
  tabline = {},
  winbar = {},
  inactive_winbar = {},
  extensions = {}
} 
    use('frazrepo/vim-rainbow')
    use('nvim-pack/nvim-spectre')
    use('tpope/vim-rhubarb')
    use('tpope/vim-surround')
    use {
    'numToStr/Comment.nvim',
    config = function()
        require('Comment').setup()
    end
}
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
use {'norcalli/nvim-colorizer.lua'}
use {'nvim-tree/nvim-web-devicons'}
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
