--[[
 _   _-
| | / /
| |/ /  ___ _   _ _ __ ___   __ _ _ __  ___
|    \ / _ \ | | | '_ ` _ \ / _` | '_ \/ __|
| |\  \  __/ |_| | | | | | | (_| | |_) \__ \
\_| \_/\___|\__, |_| |_| |_|\__,_| .__/|___/
             __/ |               | |
            |___/                |_|
--]]
local opts = { noremap = true, silent = true }

vim.api.nvim_set_keymap("n", "<F2>", "<cmd>lua vim.lsp.buf.rename()<CR>", opts)
vim.api.nvim_set_keymap("n", "<leader><leader>b", ":Telescope buffers<CR>", opts)
vim.api.nvim_set_keymap("n", "<leader><leader>g", ":Telescope live_grep<CR>", opts)
vim.api.nvim_set_keymap("n", "<leader><leader>w", ":Telescope workspaces<CR>", opts)
vim.api.nvim_set_keymap("n", "<leader><leader>c", ":CommentToggle<CR>", opts)
vim.api.nvim_set_keymap("n", "<leader><leader>f", "<cmd>lua vim.lsp.buf.formatting()<CR>", opts)

-- Stay in indent mode
vim.api.nvim_set_keymap("v", "<", "<gv", opts)
vim.api.nvim_set_keymap("v", ">", ">gv", opts)

-- visual block comment
vim.api.nvim_set_keymap("v", "<leader><leader>c", ":CommentToggle<CR>", opts)

-- As a side note, some additional keymaps exist in the handlers.lua file
-- for the language server commands such as gd for go to definition
