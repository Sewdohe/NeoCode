local status_ok, lspconfig = pcall(require, "lspconfig")
if not status_ok then
  return
end

-- Show LSP diagnostic on hovering the cursor
vim.o.updatetime = 250
vim.cmd [[autocmd! CursorHold,CursorHoldI * lua vim.diagnostic.open_float(nil, {focus=false})]]

require "lsp.lsp-installer"
require("lsp.handlers").setup()
require "lsp.lsp-signature"
require"lsp.lua-dev"
-- require "lsp.null-ls"
