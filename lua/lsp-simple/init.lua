local lsp = require('lsp-zero')
require("lsp-format").setup({})

lsp.preset('recommended')

lsp.on_attach(function(client, bufnr)
  -- Add any additional on_attach methods here
  require("lsp-format").on_attach({
    bind = true, -- This is mandatory, otherwise border config won't get registered.
    handler_opts = {
      border = "rounded"
    }
  }, bufnr)

  -- Attach the friggin' formatter finally
  require("lsp-format").on_attach(client)

  local navic = require("nvim-navic")
  navic.attach(client, bufnr)

end)

 lsp.nvim_workspace()
lsp.setup()
