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

if package.config:sub(1,1) == "/" then
  Current_Os = "unix"
else
  Current_Os = "windows"
end

-- after loading the basic settings, let's check if packer is
-- installed before loading a shitload of errors:
local fn = vim.fn
local install_path

if Current_Os == "unix" then
  install_path = fn.stdpath('data')..'/site/pack/packer/start/packer.nvim'
else
  install_path = fn.stdpath('data')..'\\site\\pack\\packer\\start\\packer.nvim'
end

if fn.empty(fn.glob(install_path)) > 0 then
  packer_bootstrap = fn.system({'git', 'clone', '--depth', '1', 'https://github.com/wbthomason/packer.nvim', install_path})
  print("installed packer")
  vim.cmd [[packadd packer.nvim]]
end

-- Use a protected call so we don't error out on first use
local status_ok, packer = pcall(require, "packer")
if not status_ok then
  return
end

packer.startup(function(use)
  use 'wbthomason/packer.nvim'

  use 'neovim/nvim-lspconfig' -- Collection of configurations for the built-in LSP client
  use 'williamboman/nvim-lsp-installer'
  use 'hrsh7th/cmp-nvim-lsp'
  use 'hrsh7th/cmp-buffer'
  use 'hrsh7th/cmp-path'
  use "nvim-lua/popup.nvim" -- An implementation of the Popup API from vim in Neovim
  use 'hrsh7th/cmp-cmdline'
  use 'hrsh7th/nvim-cmp'
  use "ray-x/lsp_signature.nvim"
  use "hrsh7th/cmp-nvim-lua"
  use "folke/lua-dev.nvim"
  use 'jubnzv/virtual-types.nvim'
  use 'j-hui/fidget.nvim'
  use 'L3MON4D3/LuaSnip'
  use 'saadparwaiz1/cmp_luasnip'
  use { "michaelb/sniprun", run = "bash ./install.sh" }
  use 'sewdohe/nvim-lines.nvim'

  -- Terminal emulator
  use "akinsho/toggleterm.nvim"

  use 'ayu-theme/ayu-vim'
  use 'rcarriga/nvim-notify'
  use "rafamadriz/neon"
  use 'norcalli/nvim-colorizer.lua'
  use 'honza/vim-snippets'
  use 'junegunn/fzf'
  use 'junegunn/fzf.vim'
  use {'nvim-telescope/telescope-fzf-native.nvim', run = 'make' }
  use 'terrortylor/nvim-comment'
  
  use {'akinsho/bufferline.nvim', requires = 'kyazdani42/nvim-web-devicons'}
  use { 'nvim-treesitter/nvim-treesitter', run = ':TSUpdate' }
  use "windwp/nvim-autopairs"
  use "romgrk/nvim-treesitter-context"
  use "windwp/nvim-ts-autotag"

  use "ahmedkhalf/project.nvim"
  use "Shatur/neovim-session-manager"

  use {
    'nvim-telescope/telescope.nvim',
    requires = { {'nvim-lua/plenary.nvim'} }
  }
  use {
    'kyazdani42/nvim-tree.lua',
    requires = {
      'kyazdani42/nvim-web-devicons', -- optional, for file icon
    }
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
    "SmiteshP/nvim-gps",
    requires = "nvim-treesitter/nvim-treesitter"
  }

  use {
    'goolord/alpha-nvim',
    requires = { 'kyazdani42/nvim-web-devicons' },
    config = function ()
        require'alpha'.setup(require'alpha.themes.startify'.config)
    end
}

  if packer_bootstrap then
    require('packer').sync()
  end

end)
