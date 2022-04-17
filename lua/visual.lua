--[[ ___      ___ ___  ________  ___  ___  ________  ___ |\  \    /  /|\  \|\   ____\|\  \|\  \|\   __  \|\  \
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
  highlight Normal ctermbg=none
  highlight NonText ctermbg=none
  highlight Normal guibg=none
  highlight NonText guibg=none
  hi! Normal ctermbg=NONE guibg=NONE
  hi! NonText ctermbg=NONE guibg=NONE
]])

vim.g.vscode_style = "dark"
vim.g.vscode_italic_comment = 1
-- Disable nvim-tree background color
vim.g.vscode_disable_nvimtree_bg = true
vim.o.background = "dark"
vim.opt.printheader = "Dari Wholesales"
-- vim.cmd[[colorscheme ayu]]
-- require('ayu').setup({
--     mirage = true, -- Set to `true` to use `mirage` variant instead of `dark` for dark background.
-- })
-- [darker, lighter, oceanic, palenight, deep ocean]
vim.g.material_style = "deep ocean"
vim.cmd 'colorscheme material'
vim.cmd([[
  highlight Comment cterm=italic gui=italic
  highlight Comment cterm=italic
]])


