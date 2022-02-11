local status_ok, _ = pcall(require, "lspconfig")
if not status_ok then
  return
end


require "lsp.lsp-installer"
require("lsp.handlers").setup()
require "lsp.lsp-signature"
require"lsp.lua-dev"

-- require "lsp.null-ls"
