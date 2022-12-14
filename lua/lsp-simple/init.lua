local lsp = require('lsp-zero')

lsp.preset('recommended')

lsp.on_attach(function(client, bufnr)
  -- Add any additional on_attach methods here
  require "lsp_signature".on_attach({
    bind = true, -- This is mandatory, otherwise border config won't get registered.
    handler_opts = {
      border = "rounded"
    }
  }, bufnr)

  local navic = require("nvim-navic")
  navic.attach(client, bufnr)

end)

lsp.nvim_workspace()
lsp.setup()
