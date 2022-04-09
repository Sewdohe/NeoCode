--[[
 ___      ___ ___  ________  ___  ___  ________  ___
|\  \    /  /|\  \|\   ____\|\  \|\  \|\   __  \|\  \
\ \  \  /  / | \  \ \  \___|\ \  \\\  \ \  \|\  \ \  \
 \ \  \/  / / \ \  \ \_____  \ \  \\\  \ \   __  \ \  \
  \ \    / /   \ \  \|____|\  \ \  \\\  \ \  \ \  \ \  \____
   \ \__/ /     \ \__\____\_\  \ \_______\ \__\ \__\ \_______\
    \|__|/       \|__|\_________\|_______|\|__|\|__|\|_______|
                     \|_________|


--]]
local colorscheme = "ayu"

local status_ok, _ = pcall(vim.cmd, "colorscheme " .. colorscheme)
if not status_ok then
	-- vim.notify("colorscheme " .. colorscheme .. " not found!")
	return
end

vim.cmd([[
  set guifont=CaskaydiaCove\ Nerd\ Font:h14
  set printfont=CaskaydiaCove\ Nerd\ Font:h14
  highlight Comment cterm=italic
]])

vim.g.vscode_style = "dark"
vim.g.vscode_italic_comment = 1
-- Disable nvim-tree background color
vim.g.vscode_disable_nvimtree_bg = true
vim.o.background = "dark"
vim.cmd[[colorscheme xresources]]

vim.cmd([[
  highlight Comment cterm=italic gui=italic
]])
