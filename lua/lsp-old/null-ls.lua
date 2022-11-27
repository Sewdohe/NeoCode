local null_ls_status_ok, null_ls = pcall(require, "null-ls")
if not null_ls_status_ok then
  return
end

local prettier = require("prettier")

prettier.setup({
  bin = 'prettier', -- or `'prettierd'` (v0.22+)
  filetypes = {
    "css",
    "graphql",
    "html",
    "javascript",
    "javascriptreact",
    "json",
    "less",
    "markdown",
    "scss",
    "typescript",
    "typescriptreact",
    "yaml",
  },
})

-- https://github.com/jose-elias-alvarez/null-ls.nvim/tree/main/lua/null-ls/builtins/formatting
local formatting = null_ls.builtins.formatting
-- https://github.com/jose-elias-alvarez/null-ls.nvim/tree/main/lua/null-ls/builtins/diagnostics
local diagnostics = null_ls.builtins.diagnostics

local group = vim.api.nvim_create_augroup("lsp_format_on_save", { clear = false })
-- local event = "BufWritePre" -- or "BufWritePost"
-- local async = event == "BufWritePost"

-- https://github.com/prettier-solidity/prettier-plugin-solidity
-- npm install --save-dev prettier prettier-plugin-solidity
null_ls.setup({
  sources = {
      null_ls.builtins.formatting.stylua,
      null_ls.builtins.diagnostics.eslint,
      null_ls.builtins.formatting.tsserver,
      null_ls.builtins.completion.spell,
  },
})
