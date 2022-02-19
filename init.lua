--[[
.########..####.##.....##.##....##.########..######..########....###....########.
.##.....##..##..##.....##.###...##.##.......##....##....##......##.##...##.....##
.##.....##..##..##.....##.####..##.##.......##..........##.....##...##..##.....##
.##.....##..##..##.....##.##.##.##.######...##..........##....##.....##.########.
.##.....##..##...##...##..##..####.##.......##..........##....#########.##...##..
.##.....##..##....##.##...##...###.##.......##....##....##....##.....##.##....##.
.########..####....###....##....##.########..######.....##....##.....##.##.....##

I've been loving using LUA for Neovim config. If you stumble upon this config, I hope you enjoy!
--]]

--[[
When configuring Vim using LUA, it will look into the "lua" folder for any requires you may need.
Use dot notation to navigate folders. Example:
if you had the directory /lua/core/settings.lua, you would use "require(core.settings)"

Here I chose not to nest that deeply just to keep the config simple, and keep from having to
navigate multiple files.
--]]
require "settings"
require "keymap"
require "packer-config"
require "visual"
require "lsp"
require "plugins.cmp"
require "plugins.lualine"
require "plugins.nvim-tree"
require "plugins.treesitter"
require "plugins.bufferline"
require "plugins.alpha"
require "plugins.project"
require "plugins.session-manager"
require "plugins.toggleterm"
require "plugins.autopairs"
require "plugins.indent-blankline"
require "plugins.dressing"
require "plugins.neorg"
require "plugins.legendary"

-- Here we load plugins which we don't configure
local status_ok, fidget = pcall(require, "fidget")
if not status_ok then
  return
end
fidget.setup{}

local status_ok, nvim_comment = pcall(require, "nvim_comment")
if not status_ok then
  return
end
nvim_comment.setup()

-- This plugin is shifting the cursor and making it hard to autocomplete to be useful
-- require"plugins.nvim-lines".register_lsp_virtual_lines()

