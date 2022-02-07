--[[
______ _             _
| ___ \ |           (_)
| |_/ / |_   _  __ _ _ _ __  ___
|  __/| | | | |/ _` | | '_ \/ __|
| |   | | |_| | (_| | | | | \__ \
\_|   |_|\__,_|\__, |_|_| |_|___/
                __/ |
               |___/
--]]

local use = require('packer').use
require('packer').startup(function()
  use 'wbthomason/packer.nvim'
  use 'neovim/nvim-lspconfig' -- Collection of configurations for the built-in LSP client
  use 'williamboman/nvim-lsp-installer'
  use 'hrsh7th/cmp-nvim-lsp'
  use 'hrsh7th/cmp-buffer'
  use 'hrsh7th/cmp-path'
  use 'hrsh7th/cmp-cmdline'
  use 'hrsh7th/nvim-cmp'
  use 'ayu-theme/ayu-vim'
  use "rebelot/kanagawa.nvim"
  use 'dracula/vim'
  use 'norcalli/nvim-colorizer.lua'
  use 'dcampos/nvim-snippy'
  use 'dcampos/cmp-snippy'
  use 'honza/vim-snippets'
  use 'junegunn/fzf'
  use 'junegunn/fzf.vim'
  use 'windwp/nvim-autopairs'
  use 'sheerun/vim-polyglot'
  use 'simrat39/rust-tools.nvim'
  use {'nvim-telescope/telescope-fzf-native.nvim', run = 'make' }
  use 'terrortylor/nvim-comment'
  use {
    'rmagatti/auto-session',
    config = function()
      require('auto-session').setup {
        log_level = 'info',
        auto_session_suppress_dirs = {'~/', '~/Projects'}
      }
    end
  }
  use 'natecraddock/workspaces.nvim'
  use {'akinsho/bufferline.nvim', requires = 'kyazdani42/nvim-web-devicons'}
  use { 'nvim-treesitter/nvim-treesitter', run = ':TSUpdate' }
  use {
    'nvim-telescope/telescope.nvim',
    requires = { {'nvim-lua/plenary.nvim'} }
  }
  use {
    'kyazdani42/nvim-tree.lua',
    requires = {
      'kyazdani42/nvim-web-devicons', -- optional, for file icon
    },
    config = function() require'nvim-tree'.setup {} end
  }
  use { 'ibhagwan/fzf-lua',
  -- optional for icon support
  requires = { 'kyazdani42/nvim-web-devicons' }
  }
  use {
   'nvim-lualine/lualine.nvim',
   requires = { 'kyazdani42/nvim-web-devicons', opt = true }
  }
  use {
    'goolord/alpha-nvim',
    requires = { 'kyazdani42/nvim-web-devicons' },
    config = function ()
        require'alpha'.setup(require'alpha.themes.dashboard'.config)
    end
  }
end)

local lspOK, _ = pcall(require, 'pluginconfig.lsp')
if not lspOK then
  return
end

local cmpOK, _ = pcall(require, 'pluginconfig.cmp')
if not cmpOK then
  return
end

local snippyOK, _ = pcall(require, 'pluginconfig.snippy')
if not snippyOK then
  return
end

local snippyOK, _ = pcall(require, 'pluginconfig.nvimtree')
if not snippyOK then
  return
end

-- Custom lualine config
require("pluginconfig.lline")

require('nvim-autopairs').setup{}
require("bufferline").setup{}
require('auto-session').setup()
require("workspaces").setup()
require('telescope').setup {
  extensions = {
    fzf = {
      fuzzy = true,                    -- false will only do exact matching
      override_generic_sorter = true,  -- override the generic sorter
      override_file_sorter = true,     -- override the file sorter
      case_mode = "smart_case",        -- or "ignore_case" or "respect_case"
                                       -- the default case_mode is "smart_case"
    }
  }
}
-- Load FZF into telescope
-- require('telescope').load_extension('fzf')
require('telescope').load_extension("workspaces")
require('nvim_comment').setup()
require('rust-tools').setup({})
