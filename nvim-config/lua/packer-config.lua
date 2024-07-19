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
if package.config:sub(1, 1) == "/" then
  OperatingSystem = "unix"
else
  OperatingSystem = "windows"
end

-- ensure packer is available before loading a bunch of errors
local ensure_packer = function()
  local fn = vim.fn
  local install_path = fn.stdpath('data')..'/site/pack/packer/start/packer.nvim'
  if fn.empty(fn.glob(install_path)) > 0 then
    fn.system({'git', 'clone', '--depth', '1', 'https://github.com/wbthomason/packer.nvim', install_path})
    vim.cmd [[packadd packer.nvim]]
    return true
  end
  return false
end

local packer_bootstrap = ensure_packer()

-- Use a protected call so we don't error out on first use
-- local status_ok, packer = pcall(require, "packer")
-- if not status_ok then
--   return
-- end

require("packer").startup(function(use)
  use({ "wbthomason/packer.nvim" })
  use({ "windwp/nvim-ts-autotag" })

  use({ "nvim-lua/plenary.nvim" })
  use {
    'VonHeikemen/lsp-zero.nvim',
    requires = {
      -- LSP Support
      { 'neovim/nvim-lspconfig' },
      { 'williamboman/mason.nvim' },
      { 'williamboman/mason-lspconfig.nvim' },

      -- Autocompletion
      { 'hrsh7th/nvim-cmp' },
      { 'hrsh7th/cmp-buffer' },
      { 'hrsh7th/cmp-path' },
      { 'saadparwaiz1/cmp_luasnip' },
      { 'hrsh7th/cmp-nvim-lsp' },
      { 'hrsh7th/cmp-nvim-lua' },
      { 'hrsh7th/cmp-cmdline' },

      -- Snippets
      { 'L3MON4D3/LuaSnip' },
      { 'rafamadriz/friendly-snippets' },
    }
  }

  -- use_rocks { "luasocket", "luafilesystem", "luaposix" }
  -- LSP and code navigation
  -- ------------------------------------
  use({ "nvim-lua/popup.nvim" }) -- An implementation of the Popup API from vim in Neovim
  use({ "ray-x/lsp_signature.nvim" })
  use 'mfussenegger/nvim-dap'
  use({ "sewdohe/nvim-adapt" })
  use({ "folke/neodev.nvim" })
  use {
    "SmiteshP/nvim-navic",
    requires = "neovim/nvim-lspconfig"
  }
  use({
    "folke/trouble.nvim",
    requires = "kyazdani42/nvim-web-devicons"
  })
  -- Can't figure out how to make this one work...
  -- use {'jubnzv/virtual-types.nvim', as = "virtual-types"}
  use({ "j-hui/fidget.nvim" })
  use({ "stevearc/aerial.nvim" })
  use({ "honza/vim-snippets" })
  use({ "terrortylor/nvim-comment" })
  use({ "jose-elias-alvarez/null-ls.nvim" })
  use({
    "folke/todo-comments.nvim",
    requires = "nvim-lua/plenary.nvim"
  })

  -- Syntax highlighter
  -- --------------------
  use({ "fladson/vim-kitty" })
  use {
    'nvim-treesitter/nvim-treesitter',
    run = function()
      require('nvim-treesitter.install').update({
        with_sync = true
      })
    end
  }
  use({ "romgrk/nvim-treesitter-context" })
  use({ "godlygeek/tabular" })
  use({ "preservim/vim-markdown" })
  use({ "ellisonleao/glow.nvim" })
  use({ 'MunifTanjim/prettier.nvim' })
  use "jose-elias-alvarez/typescript.nvim"
  use 'simrat39/rust-tools.nvim'
  use({
      "kylechui/nvim-surround",
      tag = "*", -- Use for stability; omit to use `main` branch for the latest features
  })
  use {
    'kosayoda/nvim-lightbulb',
    requires = 'antoinemadec/FixCursorHold.nvim',
  }
  use({ 'alvan/vim-closetag' })
  -- Theme / UI
  -- -----------------
  -- If you are using Packer
  use 'shaunsingh/moonlight.nvim'
  use 'feline-nvim/feline.nvim'
  use 'kdheepak/tabline.nvim'
  use 'glepnir/dashboard-nvim'
  use {
    'lewis6991/gitsigns.nvim'
  }
  use {
    "utilyre/barbecue.nvim",
    requires = {
      "smiteshp/nvim-navic",
      "kyazdani42/nvim-web-devicons", -- optional
    },
  }
  use({
    "folke/persistence.nvim",
    event = "BufReadPre", -- this will only start session saving when an actual file was opened
    module = "persistence",
    config = function()
      require("persistence").setup()
    end,
  })
  use 'Mofiqul/dracula.nvim'
  use({
    "rafamadriz/neon",
    as = "neon"
  })
  use("nekonako/xresources-nvim")
  use("Mofiqul/vscode.nvim")
  use 'navarasu/onedark.nvim'
  -- If you are using Packer
  use 'marko-cerovac/material.nvim'
  use({ "ellisonleao/gruvbox.nvim" })
  use 'frenzyexists/aquarium-vim'
  use "Shatur/neovim-ayu"
  use { "folke/zen-mode.nvim" }
  use { "folke/twilight.nvim" }
  use({ "simrat39/symbols-outline.nvim" })
  use({ "mrjones2014/legendary.nvim", tag = 'v1.0.0' })
  use("famiu/bufdelete.nvim")
  use("xiyaowong/nvim-transparent")
  use({
    "noib3/nvim-cokeline",
    requires = "kyazdani42/nvim-web-devicons" -- If you want devicons
  })
  use({
    "catppuccin/nvim",
    as = "catppuccin"
  })
  use({ "rcarriga/nvim-notify" })
  use({ "norcalli/nvim-colorizer.lua" })
  use({
    "akinsho/bufferline.nvim",
    requires = "kyazdani42/nvim-web-devicons"
  })
  use({
    "kyazdani42/nvim-tree.lua",
    requires = { "kyazdani42/nvim-web-devicons" -- optional, for file icon
    }
  })
  use({
    "nvim-lualine/lualine.nvim",
    requires = {
      "kyazdani42/nvim-web-devicons",
      opt = true
    }
  })
  use({
    "goolord/alpha-nvim",
    requires = { "kyazdani42/nvim-web-devicons" }
  })
  use({ "stevearc/dressing.nvim" })

  -- Terminal emulator
  -- ---------------------
  use({ "akinsho/toggleterm.nvim" })


  -- Search tools
  -- --------------
  use({ "junegunn/fzf" })
  use({ "junegunn/fzf.vim" })
  use({
    "ibhagwan/fzf-lua",
    requires = { "kyazdani42/nvim-web-devicons" }
  })
  use({
    "nvim-telescope/telescope.nvim",
    requires = { { "nvim-lua/plenary.nvim" } }
  })
  use({ "windwp/nvim-autopairs" })
  use({ "ahmedkhalf/project.nvim" })
  use({ "natecraddock/workspaces.nvim" })
  use({ "natecraddock/sessions.nvim" })
  use({ "JoseConseco/telescope_sessions_picker.nvim" })

  local user_ok, user = pcall(require, "user.plugins")
  if not user_ok then
    -- print("No custom user config")
  else
    -- print("loading custom config...")
    for _, value in ipairs(user) do
      if value then
        use({ value })
      end
    end
  end
  if packer_bootstrap then
    print("first start - running packer sync")
    require('packer').sync()
  end
end)
