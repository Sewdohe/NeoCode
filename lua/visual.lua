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
local colorscheme = "dracula"

local status_ok, _ = pcall(vim.cmd, "colorscheme " .. colorscheme)
if not status_ok then
  -- This message was annoying. Leaving it just in-case though
	-- vim.notify("colorscheme " .. colorscheme .. " not found!")
	return
end

vim.cmd([[
  set printfont=CaskaydiaCove\ Nerd\ Font:h14
  highlight Comment cterm=italic gui=italic
  highlight Normal ctermbg=none
  highlight NonText ctermbg=none
  highlight Normal guibg=none
  highlight NonText guibg=none
  hi! Normal ctermbg=NONE guibg=NONE
  hi! NonText ctermbg=NONE guibg=NONE
]])

vim.g.vscode_style = "light"
vim.g.vscode_italic_comment = 1
vim.g.vscode_disable_nvimtree_bg = true
vim.o.background = "dark"
vim.opt.printheader = "Dari Wholesales"
vim.g.material_style = "darker"

-- customize dracula color palette
vim.g.dracula_colors = {
  bg = "#21222c",
  fg = "#F8F8F2",
  selection = "#44475A",
  comment = "#6272A4",
  red = "#FF5555",
  orange = "#FFB86C",
  yellow = "#F1FA8C",
  green = "#50fa7b",
  purple = "#BD93F9",
  cyan = "#8BE9FD",
  pink = "#FF79C6",
  bright_red = "#FF6E6E",
  bright_green = "#69FF94",
  bright_yellow = "#FFFFA5",
  bright_blue = "#D6ACFF",
  bright_magenta = "#FF92DF",
  bright_cyan = "#A4FFFF",
  bright_white = "#FFFFFF",
  menu = "#21222C",
  visual = "#3E4452",
  gutter_fg = "#4B5263",
  nontext = "#3B4048",
}
-- show the '~' characters after the end of buffers
vim.g.dracula_show_end_of_buffer = true
-- use transparent background
vim.g.dracula_transparent_bg = true
-- set custom lualine background color
vim.g.dracula_lualine_bg_color = "#44475a"
-- set italic comment
vim.g.dracula_italic_comment = true

vim.cmd[[colorscheme dracula]]
