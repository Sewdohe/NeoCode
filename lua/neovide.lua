-- Neovide specific settings
if vim.g.neovide then
  vim.cmd([[
    hi Normal guibg=NONE ctermbg=NONE
    set guifont=CaskaydiaCove\ Nerd\ Font:h10
  ]])
  vim.g.neovide_refresh_rate=144
  vim.g.neovide_remember_window_size = true
  -- UNCOMMENT if you want transparent BG
  -- your theme must also have a transparent BG for this to work

  -- vim.g.neovide_transparency = 0.0
  -- vim.g.transparency = 0.8

end
