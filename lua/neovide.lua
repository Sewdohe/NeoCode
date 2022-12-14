-- Neovide specific settings
if vim.g.neovide then
  vim.cmd([[
    hi Normal guibg=NONE ctermbg=NONE
    set guifont=MesloLGS\ NF:h8
  ]])
end


vim.g.neovide_refresh_rate=144
vim.g.neovide_remember_window_size = false
-- vim.g.neovide_transparency = 0.0
-- vim.g.transparency = 0.8


-- vim.cmd("colorscheme kanagawa")
-- vim.cmd[[colorscheme dracula]]
require('ayu').setup({})
-- require('moonlight').set()
