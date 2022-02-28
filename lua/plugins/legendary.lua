local status_ok, legendary = pcall(require, "legendary")
if not status_ok then
	return
end

local opts = { noremap = true, silent = true }
-- Use lazygit to handle github repos
local status_ok, toggleterm = pcall(require, "toggleterm.terminal")
if not status_ok then
	return
end
local lazygit = toggleterm.Terminal:new({ cmd = "lazygit", hidden = true, dir = "git_dir" })

local function _lazygit_toggle()
  lazygit:toggle()
end

local custom_mappings = {
	{ "<C-b>", ":NvimTreeToggle<CR>", description = "Toggle file tree", opts = opts },
	-- cutting and pasting lines
	{ "<C-x>", "dd", mode = "n", description = "Cut Line", opts = opts },
	{ "<C-v>", "p", opts = opts },
	{ "<C-v>", "p", mode = "n", opts = opts },
	{ "<C-k>", legendary.find, description = "Search key bindings" },
	-- Document jumping since we re-bind file tree to C-b
	{ "J", "<C-f>", opts = opts, description = "Jump forward in document" },
	{ "K", "<C-b>", opts = opts, description = "Jump backward in document" },
	-- call lazygit with control g
	{ '<C-g>', _lazygit_toggle, opts = opts, description = 'Toggle LazyGit terminal' },
	{ "gt", "<Plug>(cokeline-focus-prev)", opts = opts, description = "Previous tab" },
	{ "gy", "<Plug>(cokeline-focus-next)", opts = opts, description = "Next tab" },
	{ "<C-p>", ":Telescope git_files<CR>", opts = opts, description = "Find File" },
	{ "<C-o>", ":SymbolsOutline<CR>", opts = opts, description = "Browse Symbols" },
  -- Commenting
	{ "<leader><leader>c", ":CommentToggle<CR>", mode = 'v', opts = opts, description = "Toggle Comment" },
	{ "<leader><leader>c", ":CommentToggle<CR>", mode = 'n', opts = opts, description = "Toggle Comment" },
  -- folding
	{ "<C-]", "za", mode = 'n', opts = opts, description = "Fold Out" },
	{ "<C-[", "zc", mode = 'n', opts = opts, description = "Fold In" },
  { "gt", "<PLUG>(cokeline-focus-prev)", opts = opts, description = "Next Tab"},
  { "gy", "<PLUG>(cokeline-focus-next)", opts = opts, description = "Next Tab"},
  { "H", ":BufferLineCyclePrev<CR>", opts = opts, description = "Next Tab (alternate)"},
  { "L", ":BufferLineCycleNext<CR>", opts = opts, description = "Next Tab (alternate)"},
  -- ease of use
  {"qq", "<ESC>", mode = "i", opts = opts, description = "Exit insert mode / ESC key"},
  {"qb", ":Bdelete<CR>", opts = opts, description = "Close current buffer / tab"},
  {"<c-s>", ":w<CR>", opts = {noremap = true, silent = false}, description = "Save file"}
}

local commands = {
  -- You can also use legendar.nvim to create commands!
  { ':DoSomething', ':echo "something"', description = 'Do something!' },
  { ':Reload', ':so ./init.lua', description = 'Refresh Config' }
}

legendary.setup({
	-- Include builtins by default, set to false to disable
	include_builtin = true,
	-- Customize the prompt that appears on your vim.ui.select() handler
	select_prompt = "Legendary",
	-- Initial keymaps to bind
	keymaps = custom_mappings,
	-- Initial commands to create
	commands = commands,
	-- Automatically add which-key tables to legendary
	-- when you call `require('which-key').register()`
	-- for this to work, you must call `require('legendary').setup()`
	-- before any calls to `require('which-key').register()`, and
	-- which-key.nvim must be loaded when you call `require('legendary').setup()`
	auto_register_which_key = false,
})
