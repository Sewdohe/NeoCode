-- Neovide specific settings
if vim.g.neovide then
  vim.cmd([[
    set guifont=MesloLGS\ Nerd\ Font:h11
  ]])
end


vim.g.neovide_refresh_rate=144
vim.g.neovide_remember_window_size = false

vim.g.neovide_transparency = 1
vim.g.transparency = 1

require("catppuccin").setup()

-- vim.cmd[[colorscheme dracula]]
vim.cmd.colorscheme "catppuccin"
