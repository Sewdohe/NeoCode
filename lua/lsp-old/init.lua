local status_ok, lspconfig = pcall(require, "lspconfig")
if not status_ok then
  return
end

local status_ok, handlers = pcall(require, "lsp.handlers")

-- Show LSP diagnostic on hovering the cursor
vim.o.updatetime = 250
vim.cmd[[autocmd! CursorHold,CursorHoldI * lua vim.diagnostic.open_float(nil, {focus=false})]]

require'lspconfig'.tsserver.setup{}

require "lsp.lsp-installer"
if(handlers) then
  handlers.setup()
end

require "lsp.lsp-signature"
require"lsp.lua-dev"
require "lsp.null-ls"
