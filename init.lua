--[[
.########..####.##.....##.##....##.########..######..########....###....########.
.##.....##..##..##.....##.###...##.##.......##....##....##......##.##...##.....##
.##.....##..##..##.....##.####..##.##.......##..........##.....##...##..##.....##
.##.....##..##..##.....##.##.##.##.######...##..........##....##.....##.########.
.##.....##..##...##...##..##..####.##.......##..........##....#########.##...##..
.##.....##..##....##.##...##...###.##.......##....##....##....##.....##.##....##.
.########..####....###....##....##.########..######.....##....##.....##.##.....##

I'\ve been loving using LUA for Neovim config. If you stumble upon this config, I hope you enjoy!
--]]

--[[
When configuring Vim using LUA, it will look into the "lua" folder for any requires you may need.
Use dot notation to navigate folders. Example:
if you had the directory /lua/core/settings.lua, you would use "require(core.settings)"

Here I chose not to nest that deeply just to keep the config simple, and keep from having to
navigate multiple files.

The only plugin with nested folders is the LSP plugin, due to the complex nature of it.
--]]

-- IMPORTANT!!! Leader key is comma (,)
-- Example: Keyybind <leader><leader>c means press comma twice followed by the c key to perform action


require("settings") -- some base settings every Vim install should have
require("keymap") -- loads some default keymaps that haven't been moved into legendary yet
require("packer-config") -- Configuation for package manager "Packer"
require("visual") -- Visual settings for this Neovim insance
require("plugins.transparent")
require("lsp") -- Language server support.
require("plugins.cmp") -- auto completion pluign for LSP
require"plugins.lualine" -- OLD - we use cokeline now.
require("plugins.nvim-tree") -- File tree for browsing open directory
require("plugins.treesitter") -- Syntax highlighter. Instal new filetypes with :TSInstall
require("plugins.twilight")
require("plugins.alpha") -- Neovim start page with shortcuts
require("plugins.project") -- adds folders with .git folder or .project file as a "project"
require("plugins.session-manager") -- manages coding sessions. Similar to workspaces.
require("plugins.toggleterm") -- toggable terminal for Neovim. Toggle with ctrl+` (key with ~ (tilde) on it)
require("plugins.autopairs") -- auto close brackets/pairs
require("plugins.dressing") -- Provides pop-up boxes and other GUI-like elements
require("plugins.neorg") -- Org support in Neovim
require("plugins.legendary") -- Shows a searchable list of key-binds, an ease of use plugin that lets you discover new binds.
require("plugins.workspaces") -- allows creating "workspaces" to just right back into what you were doing
require("neovide") -- loads settings that are just for the GUI wrapper, Neovide
require("plugins.telescope")

-- Here we load plugins which we don't configure
local fidget_ok, fidget = pcall(require, "fidget")
if not fidget_ok then
	return
end
fidget.setup({})

-- Comment out lines or visualy selected blocks with <leader><leader>c (<,,c>)
local nvim_comment_okay, nvim_comment = pcall(require, "nvim_comment")
if not nvim_comment_okay then
	return
end
nvim_comment.setup()

-- This plugin is shifting the cursor and making it hard to autocomplete to be useful
-- require"plugins.nvim-lines".register_lsp_virtual_lines()

-- Load user custom configs here, lastly, to override configs from the repo
local user_okay, user = pcall(require, "user")
if not user_okay then
	return
end

-- We require cokeline lastly, to ensure that the colors it gets is from the last set theme.
-- If we load it before user config, the cokeline colors always match the default VS code theme.
require"plugins.cokeline" -- Bufferline that shows tabs for each open document
