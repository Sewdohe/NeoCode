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
  vim.notify("colorscheme " .. colorscheme .. " not found!")
  return
end


if vim.g.neovide then
  -- set neovide specific settings here
  -- (neovide is a fantastic Neovimm GUI wrapper, check it out!!!)
   vim.cmd([[
   " let ayucolor="light"
   colorscheme ayu
   ]])
else
  vim.cmd([[
  let ayucolor="dark"
  colorscheme ayu
  ]])
end

vim.cmd([[
    set guifont=CaskaydiaCove\ Nerd\ Font:h12
]])


