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

local lazygit = toggleterm.Terminal:new({ cmd = "lazygit", hidden = true})

function _lazygit_toggle()
	lazygit:toggle()
end

-- we assign these based on where we are running Neovim
local tabSwitchPrev
local tabSwitchNext
local fileTreeFocus

if vim.g.vscode then
  tabSwitchPrev = { "H", ":Tabprev<CR>", opts = opts, description = "Prev Tab (alternate)" }
  tabSwitchNext = { "L", ":Tabnext<CR>", opts = opts, description = "Next Tab (alternate)" }
	fileTreeFocus = { "<C-b>", "<Cmd>call VSCodeNotify('workbench.explorer.fileView.focus')<CR>", description = "focus file tree", opts = opts }
end
if not vim.g.vscode then
	tabSwitchPrev = { "H", "<Plug>(cokeline-focus-prev)<CR>", opts = opts, description = "Next Tab (alternate)" }
	tabSwitchNext = { "L", "<Plug>(cokeline-focus-next)<CR>", opts = opts, description = "Next Tab (alternate)" }
  fileTreeFocus = { "<C-b>", ":NvimTreeToggle<CR>", description = "Toggle file tree", opts = opts }
end

-- TODO: Add lazygit as a dep to install with installer

local custom_mappings = {
	-- cutting and pasting lines
	{ "<C-x>", "dd", mode = "n", description = "Cut Line", opts = opts },
	{ "<C-v>", "p", opts = opts },
	{ "<C-v>", "p", mode = "n", opts = opts },
	{ "<C-k>", legendary.find, description = "Search key bindings" },

	-- Document jumping since we re-bind file tree to C-b
	{ "J", "<C-f>", opts = opts, description = "Jump forward in document" },
	{ "K", "<C-b>", opts = opts, description = "Jump backward in document" },

	-- call lazygit with control g
	{ "<C-g>", "<cmd>lua _lazygit_toggle()<CR>", opts = opts, description = "Toggle LazyGit terminal" },
	{ "<C-p>", ":Telescope git_files<CR>", opts = opts, description = "Find File" },
	{ "<C-o>", ":SymbolsOutline<CR>", opts = opts, description = "Browse Symbols" },

	-- Commenting
	{ "<leader><leader>c", ":CommentToggle<CR>", mode = "v", opts = opts, description = "Toggle Comment" },
	{ "<leader><leader>c", ":CommentToggle<CR>", mode = "n", opts = opts, description = "Toggle Comment" },

	-- folding
	{ "<C-]", "za", mode = "n", opts = opts, description = "Fold Out" },
	{ "<C-[", "zc", mode = "n", opts = opts, description = "Fold In" },
	{ "gt", "<Plug>(cokeline-focus-prev)", opts = opts, description = "Next Tab" },
	{ "gy", "<Plug>(cokeline-focus-next)", opts = opts, description = "Next Tab" },
  tabSwitchPrev,
  tabSwitchNext,
  fileTreeFocus,

	-- ease of use
	{ "qq", "<ESC>", mode = "i", opts = opts, description = "Exit insert mode / ESC key" },
	{ "qb", ":Bdelete<CR>", opts = opts, description = "Close current buffer / tab" },
	{ "<c-s>", ":w<CR>", opts = { noremap = true, silent = false }, description = "Save file" },
	{ "<c-s>", ":w<CR>", mode = "i", opts = { noremap = true, silent = false }, description = "Save file" },
  {"<leader><leader>z", ":ZenMode <CR>", opts = opts, description = "UI: Toggle Zen Mode"},
  {"<leader><leader>t", ":TransparentToggle <CR>", opts = opts, description = "UI: Toggle Transparency"},
	{ "<leader><leader>h", ":Alpha<CR>", description = "Return to Home Screen", opts = opts },

  -- LSP completion and diagnostics
  {"<leader><leader>t", ":TroubleToggle document_diagnostics<CR>", opts = opts, description = "lsp: View Diagnostics List"},
  {"<leader><leader>T", ":TroubleToggle workspace_diagnostics<CR>", opts = opts, description = "lsp: View Workspace Diagnostics List"},
  {"gD", "<cmd>lua vim.lsp.buf.declaration()<CR>", opts = opts, description = "lsp: goto declaration"},
  {"gd", "<cmd>lua vim.lsp.buf.definition()<CR>", opts = opts, description = "lsp: goto definition"},
  {"gr", "<cmd>lua vim.lsp.buf.refrences()<CR>", opts = opts, description = "lsp: goto refrences"},
  {"gI", "<cmd>lua vim.lsp.buf.implementation()<CR>", opts = opts, description = "lsp: goto implementation"},
  {"<c-space>", "<cmd>lua vim.lsp.buf.hover()<CR>", opts = opts, description = "lsp: show hover window"},
  {"<leader>ca", "<cmd>lua vim.lsp.buf.code_action()<CR>", opts = opts, description = "lsp: perform code action"},
  {"[d", '<cmd>lua vim.diagnostic.goto_prev({ border = "rounded"})<CR>', opts = opts, description = "lsp: goto prev diagnostic"},
  {"]d", '<cmd>lua vim.diagnostic.goto_next({ border = "rounded"})<CR>', opts = opts, description = "lsp: goto next diagnostic"},
  {"<leader>q", "<cmd>lua vim.diagnostic.setloclist()<CR>", opts = opts, description = "lsp: set local list"},
}

local status_ok, user_mappings = pcall(require, "user.keybinds")
if status_ok then
	for _, v in pairs(user_mappings) do
		table.insert(custom_mappings, v)
	end
end

local commands = {
	-- You can also use legendar.nvim to create commands!
	{ ":SaveAndRealoadFile", ':w | :so %', description = "Saves and re-sources the file into Neovim" },
	{ ":ReloadNeoCode", ":so ./init.lua", description = "Refresh Config" },
  { ":OpenWork", ":lua open_work()", description = "Open work folder to current day"}
}

open_work = function()
  require "lfs"

  vim.cmd([[
    cd ~/Documents/Work Orders
  ]])
	
  local today = os.date("%B %d")
	local todays_dir = "~/Documents/Work Orders/" .. today
	local is_dir = lfs.chdir(today) and true or false

  if(not is_dir) then
    lfs.mkdir('~/Documents/Work Orders/' .. today)
  end
end

local status_ok, user_commands = pcall(require, "user.commands")
if status_ok then
	for _, v in pairs(user_commands) do
		table.insert(commands, v)
	end
end

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
