-- Neovide specific settings
if vim.g.neovide then
  vim.cmd([[
    let g:neovide_refresh_rate=144
    let g:neovide_remember_window_size = v:true
    set guifont=CaskaydiaCove\ Nerd\ Font:h10
  ]])
end
