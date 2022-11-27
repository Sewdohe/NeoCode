--[[
___      ___ ___  ________  ___  ___  ________  ___ |
\\  \    /  /|\  \|\   ____\|\  \|\  \|\   __  \|\  \
\ \  \  /  / | \  \ \  \___|\ \  \\\  \ \  \|\  \ \  \
 \ \  \/  / / \ \  \ \_____  \ \  \\\  \ \   __  \ \  \
  \ \    / /   \ \  \|____|\  \ \  \\\  \ \  \ \  \ \  \____
   \ \__/ /     \ \__\____\_\  \ \_______\ \__\ \__\ \_______\
    \|__|/       \|__|\_________\|_______|\|__|\|__|\|_______|
                     \|_________|
--]]
local colorscheme = "vscode"

local status_ok, _ = pcall(vim.cmd, "colorscheme " .. colorscheme)
if not status_ok then
  -- This message was annoying. Leaving it just in-case though
	-- vim.notify("colorscheme " .. colorscheme .. " not found!")
	return
end

vim.cmd([[
  set printfont=CaskaydiaCove\ Nerd\ Font:h10
  highlight Comment cterm=italic gui=italic
  highlight Normal ctermbg=none
  highlight NonText ctermbg=none
  highlight Normal guibg=none
  highlight NonText guibg=none
  hi! Normal ctermbg=NONE guibg=NONE
  hi! NonText ctermbg=NONE guibg=NONE

  set laststatus=3
  highlight WinSeparator guibg=None
]])

vim.g.vscode_style = "dark"
vim.g.vscode_italic_comment = 1
vim.g.vscode_disable_nvimtree_bg = true

local status_ok, vscode = pcall(require, "vscode")
if not status_ok then
  return
end

vscode.setup({
  -- Enable transparent background
  transparent = false,

  -- Enable italic comment
  italic_comments = true,

  -- Disable nvim-tree background color
  disable_nvimtree_bg = true,
})
