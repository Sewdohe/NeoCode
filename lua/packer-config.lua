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
  OperatingSystem = "unix"
else
  OperatingSystem = "windows"
end

-- after loading the basic settings, let's check if packer is
-- installed before loading a shitload of errors:
local fn = vim.fn
local install_path

if OperatingSystem == "unix" then
  install_path = fn.stdpath('data')..'/site/pack/packer/start/packer.nvim'
else
  install_path = fn.stdpath('data')..'\\site\\pack\\packer\\start\\packer.nvim'
end

if fn.empty(fn.glob(install_path)) > 0 then
  print("Installing packer to: " .. install_path)
  Packer_bootstrap = fn.system({'git', 'clone', '--depth', '1', 'https://github.com/wbthomason/packer.nvim', install_path})
  print("installed packer")
  vim.cmd [[packadd packer.nvim]]
end

-- Use a protected call so we don't error out on first use
local status_ok, packer = pcall(require, "packer")
if not status_ok then
  return
end

packer.startup(function(use)
  -- use this commit for now, windows support is broken
  use {
    "wbthomason/packer.nvim",
    commit = "62a69fb4cc995d17688a015df1f0bf890d9a201c",
    as = "packer"
}

  -- LSP and code navigation
  -- ------------------------------------
  use {'neovim/nvim-lspconfig', as = "lspconfig"} -- Collection of configurations for the built-in LSP client
  use {'williamboman/nvim-lsp-installer', as = "lsp-installer"}
  use {'hrsh7th/cmp-nvim-lsp', as ="cmp-nvim-lsp"}
  use {'hrsh7th/cmp-buffer', as = "cmp-buffer"}
  use {'hrsh7th/cmp-path', as = "cmp-path"}
  use {"nvim-lua/popup.nvim", as = "popup"} -- An implementation of the Popup API from vim in Neovim
  use {'hrsh7th/cmp-cmdline', as = "cmp-cmdline"}
  use {'hrsh7th/nvim-cmp', as = "nvim-cmp"}
  use {"ray-x/lsp_signature.nvim", as = "lsp-signature"}
  use {"hrsh7th/cmp-nvim-lua", as = "cmp-nvim-lua"}
  use {"folke/lua-dev.nvim", as = "lua-dev"}
  -- Can't figure out how to make this one work...
  -- use {'jubnzv/virtual-types.nvim', as = "virtual-types"}
  use {'j-hui/fidget.nvim', as = "fidget"}
  use {'L3MON4D3/LuaSnip', as = "lua-snip"}
  use {'saadparwaiz1/cmp_luasnip', as = "cmp-luasnip"}
  use {'stevearc/aerial.nvim', as = "aerial"}
  use {'honza/vim-snippets', as = "vim-snippets"}
  use {'terrortylor/nvim-comment', as = "nvim_comment"}
  use {'jose-elias-alvarez/null-ls.nvim', as = "null-ls"}

  -- Syntax highlighter
  -- ---------------------
  use { 'nvim-treesitter/nvim-treesitter', run = ':TSUpdate', as = "nvim-treesitter" }
  use {"romgrk/nvim-treesitter-context", as = "nvim-treesitter-context"}

  -- Theme / UI
  -- -----------------
  use({
    "catppuccin/nvim",
    as = "catppuccin"
  })
  use {'rcarriga/nvim-notify', as = "notify"}
  use {'norcalli/nvim-colorizer.lua', as = "colorizer"}
  use {
    'akinsho/bufferline.nvim', 
    requires = 'kyazdani42/nvim-web-devicons', 
    as = "bufferline"}
  use {
    'kyazdani42/nvim-tree.lua',
    requires = {
      'kyazdani42/nvim-web-devicons', -- optional, for file icon
    },
    as = "nvim-tree"
  }
  use {
   'nvim-lualine/lualine.nvim',
   requires = { 'kyazdani42/nvim-web-devicons', opt = true },
   as = "lualine"
  }
  use {
    'goolord/alpha-nvim',
    requires = { 'kyazdani42/nvim-web-devicons' },
    as = "alpha"
  }
  use {"lukas-reineke/indent-blankline.nvim", as = "indent-line"}
  use {'stevearc/dressing.nvim', as = "dressing"}

  -- Terminal emulator
  -- ---------------------
  use {"akinsho/toggleterm.nvim", as = "toggleterm"}

  -- Search tools
  -- --------------
  use {'nvim-lua/plenary.nvim', as = "plenary"}
  use {'junegunn/fzf', as = "fzf"}
  use {'junegunn/fzf.vim', as = "fzf-vim"}
  use {'nvim-telescope/telescope-fzf-native.nvim', run = 'make', as = "telescope-fzf" }
  use { 'ibhagwan/fzf-lua',
  -- optional for icon support
  requires = { 'kyazdani42/nvim-web-devicons' },
  as = "fzf-lua"
  }
  use {
    'nvim-telescope/telescope.nvim',
    requires = { {'nvim-lua/plenary.nvim'} },
    as = "telescope"
  }

  
  use {"windwp/nvim-autopairs", as = "autopairs"}
  use {"ahmedkhalf/project.nvim", as = "project"}
  use {"Shatur/neovim-session-manager", as = "session-manager"}



  if Packer_bootstrap then
    require('packer').sync()
  end

end)
