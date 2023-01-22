--[[

        
        
.########..####.##.....##.##....##.########..######..########....###....########.
.##.....##..##..##.....##.###...##.##.......##....##....##......##.##...##.....##
.##.....##..##..##.....##.####..##.##.......##..........##.....##...##..##.....##
.##.....##..##..##.....##.##.##.##.######...##..........##....##.....##.########.
.##.....##..##...##...##..##..####.##.......##..........##....#########.##...##..
.##.....##..##....##.##...##...###.##.......##....##....##....##.....##.##....##.
.########..####....###....##....##.########..######.....##....##.....##.##.....##

I've been loving using LUA for Neovim config. If you stumble upon this config, I hope you enjoy!
--]]

--[[
When configuring Vim using LUA, it will look into the "lua" folder for any requires you may need.
Use dot notation to navigate folders. Example:
if you had the directory /lua/core/settings.lua, you would use "require(core.settings)"

Here I chose not to nest that deeply just to keep the config simple, and keep from having to
navigate multiple files.

The only plugin with nested folders is the LSP plugin, due to the complex nature of it.
--]]

-- IMPORTANT!!! Leader key is comma (,)
-- Example: Keyybind <leader><leader>c means press comma twice followed by the c key to perform action

require("packer-config")

-- Configuation for package manager "Packer"
if vim.g.vscode then
  require("settings") -- some base settings every Vim install should have
  require("keymap") -- loads some default keymaps that haven't been moved into legendary yet
  require("plugins.ui.legendary") -- Shows a searchable list of key-binds, an ease of use plugin that lets you discover new binds.
else
  -------------------- CORE SETTINGS ------------------------------
  --=============================================================

  require("settings") -- some base settings every Vim install should have
  require("keymap") -- loads some default keymaps that haven't been moved into legendary yet
  require("visual") -- Visual settings for this Neovim insance
  require("lsp") -- Language server support.
  require("autocommands")
  -------------------- SYNTAX PLUGINS ------------------------------
  --=============================================================
  require("plugins.syntax.treesitter") -- Syntax highlighter. Instal new filetypes with :TSInstall <filetype | all>

  --------------------- EDITOR PLUGINS ------------------------------
  --=============================================================
  require("plugins.editor.autopairs") -- ....it auto-pairs things
  require("plugins.editor.project") -- adds folders with .git folder or .project file as a "project"
  require("plugins.editor.toggleterm") -- toggable terminal for Neovim. Toggle with ctrl+` (key with ~ (tilde) on it)
  require("plugins.editor.symbol-outline") -- shows file overview in a sidebar
  require("plugins.editor.session-manager") -- manages coding sessions. Similar to workspaces.
  require("plugins.editor.workspaces") -- allows creating "workspaces" to just right back into what you were doing
  require("plugins.editor.trouble") -- Diagnostics on crack
  require("plugins.editor.surround")

  --------------------- UI PLUGINS ------------------------------
  --=============================================================
  require("plugins.ui.nvim-tree") -- File tree for browsing open directory
  require("plugins.ui.twilight")
  require("plugins.ui.alpha") -- Neovim start page with shortcuts
  require("plugins.ui.legendary") -- Shows a searchable list of key-binds, an ease of use plugin that lets you discover new binds.
  require("plugins.ui.zenmode") -- focus on your code
  require("plugins.ui.telescope") -- awesome UI-like universal thing-picker
  require("plugins.ui.dressing") -- Provides pop-up boxes and other GUI-like elements
  require("plugins.ui.bbq")
  require("plugins.ui.gitsign")
  require("plugins.ui.feline") -- Neovim status line (bottom bar)
  require("plugins.ui.cokeline")
end

-- Here we load plugins which we don't configure
local fidget_ok, fidget = pcall(require, "fidget")
if not fidget_ok then
  return
end
fidget.setup({})

-- Comment out lines or visualy selected blocks with <leader><leader>c (<,,c>)
local nvim_comment_okay, nvim_comment = pcall(require, "nvim_comment")
if not nvim_comment_okay then
  return
end
nvim_comment.setup()

vim.g.closetag_filenames = "*.html,*.xhtml,*.phtml,*.tsx, *.jsx"
vim.cmd([[
let g:closetag_regions = {
    \ 'typescript.tsx': 'jsxRegion,tsxRegion',
    \ 'javascript.jsx': 'jsxRegion',
    \ 'typescriptreact': 'jsxRegion,tsxRegion',
    \ 'javascriptreact': 'jsxRegion',
    \ }
]])

-- Load user custom configs here, lastly, to override configs from the repo
local user_okay = pcall(require, "user")
if not user_okay then
  return
end

require("neovide") -- loads settings that are just for the GUI wrapper, Neovide
