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
local opts = { noremap=true, silent=true }
vim.api.nvim_set_keymap('n', '<space>e', '<cmd>lua vim.diagnostic.open_float()<CR>', opts)
vim.api.nvim_set_keymap('n', '[d', '<cmd>lua vim.diagnostic.goto_prev()<CR>', opts)
vim.api.nvim_set_keymap('n', ']d', '<cmd>lua vim.diagnostic.goto_next()<CR>', opts)
vim.api.nvim_set_keymap('n', '<space>q', '<cmd>lua vim.diagnostic.setloclist()<CR>', opts)
vim.api.nvim_set_keymap('n', '<leader><leader>t', ':NvimTreeToggle<CR>', opts)
vim.api.nvim_set_keymap('n', '<leader><leader>h', ':BufferLineCyclePrev<CR>', opts)
vim.api.nvim_set_keymap('n', '<leader><leader>l', ':BufferLineCycleNext<CR>', opts)
vim.api.nvim_set_keymap('n',
  '<leader><leader>f',
  ':Telescope find_files find_command=rg,--ignore,--hidden,--files prompt_prefix=🔍<CR>',
  opts)
vim.api.nvim_set_keymap('n', '<leader><leader>b', ':Telescope buffers<CR>', opts)
vim.api.nvim_set_keymap('n', '<leader><leader>g', ':Telescope live_grep<CR>', opts)
vim.api.nvim_set_keymap('n', '<leader><leader>w', ':Telescope workspaces<CR>', opts)
vim.api.nvim_set_keymap('n', '<leader><leader>c', ':CommentToggle<CR>', opts)
-- Stay in indent mode
vim.api.nvim_set_keymap("v", "<", "<gv", opts)
vim.api.nvim_set_keymap("v", ">", ">gv", opts)

vim.api.nvim_set_keymap('n', '<space>e', '<cmd>lua vim.diagnostic.open_float()<CR>', opts)
vim.api.nvim_set_keymap('n', '[d', '<cmd>lua vim.diagnostic.goto_prev()<CR>', opts)
vim.api.nvim_set_keymap('n', ']d', '<cmd>lua vim.diagnostic.goto_next()<CR>', opts)
vim.api.nvim_set_keymap('n', '<space>q', '<cmd>lua vim.diagnostic.setloclist()<CR>', opts)
vim.api.nvim_set_keymap("n", "<space>ca", "<cmd>lua vim.lsp.buf.code_action()<CR>", opts)

-- visual block comment
vim.api.nvim_set_keymap("v", "<leader><leader>c", ':CommentToggle<CR>', opts)

-- As a side note, some additional keymaps exist in the LSP-setup.lua file
-- for the language server commands such as gd for go to definition
