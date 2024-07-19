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
  -- require("plugins.ui.filemanager") -- File tree for browsing open directory
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

-- Having to move nvimtree setup outside of the setup-file
-- for whatever reason it won't load from an external file.
-- TODO: Figure this out and fix it. I don't like having huge configs inside init.lua.
require('nvim-tree').setup {
  auto_reload_on_write = true,
    create_in_closed_folder = false,
    disable_netrw = false,
    hijack_cursor = false,
    hijack_netrw = true,
    hijack_unnamed_buffer_when_opening = false,
    open_on_tab = false,
    sort_by = "name",
    root_dirs = {},
    prefer_startup_root = false,
    update_cwd = false,
    reload_on_bufenter = false,
    respect_buf_cwd = false,
    view = {
      adaptive_size = false,
      centralize_selection = false,
      width = 30,
      side = "left",
      preserve_window_proportions = false,
      number = false,
      relativenumber = false,
      signcolumn = "yes",
    },
    renderer = {
      add_trailing = false,
      group_empty = false,
      highlight_git = true,
      full_name = false,
      highlight_opened_files = "none",
      root_folder_modifier = ":~",
      indent_markers = {
        enable = false,
        icons = {
          corner = "└ ",
          edge = "│ ",
          item = "│ ",
          none = "  ",
        },
      },
      icons = {
        webdev_colors = true,
        git_placement = "before",
        padding = " ",
        symlink_arrow = " ➛ ",
        show = {
          file = true,
          folder = true,
          folder_arrow = true,
          git = true,
        },
        glyphs = {
          default = "",
          symlink = "",
          folder = {
            arrow_closed = "",
            arrow_open = "",
            default = "",
            open = "",
            empty = "",
            empty_open = "",
            symlink = "",
            symlink_open = "",
          },
          git = {
            unstaged = "✗",
            staged = "✓",
            unmerged = "",
            renamed = "➜",
            untracked = "★",
            deleted = "",
            ignored = "◌",
          },
        },
      },
      special_files = { "Cargo.toml", "Makefile", "README.md", "readme.md" },
    },
    hijack_directories = {
      enable = true,
      auto_open = true,
    },
    update_focused_file = {
      enable = false,
      update_cwd = false,
      update_root = false,
      ignore_list = {},
    },
    system_open = {
      cmd = "",
      args = {},
    },
    diagnostics = {
      enable = false,
      show_on_dirs = false,
      icons = {
        hint = "",
        info = "",
        warning = "",
        error = "",
      },
    },
    filters = {
      dotfiles = true,
      custom = {},
      exclude = {},
    },
    filesystem_watchers = {
      enable = true,
      -- interval = 100,
    },
    git = {
      enable = true,
      ignore = false,
      timeout = 400,
    },
    actions = {
      use_system_clipboard = true,
      change_dir = {
        enable = true,
        global = false,
        restrict_above_cwd = false,
      },
      expand_all = {
        max_folder_discovery = 300,
      },
      open_file = {
        quit_on_open = false,
        resize_window = true,
        window_picker = {
          enable = true,
          chars = "ABCDEFGHIJKLMNOPQRSTUVWXYZ1234567890",
          exclude = {
            filetype = { "notify", "packer", "qf", "diff", "fugitive", "fugitiveblame" },
            buftype = { "nofile", "terminal", "help" },
          },
        },
      },
      remove_file = {
        close_window = true,
      },
    },
    trash = {
      cmd = "gio trash",
      require_confirm = true,
    },
    live_filter = {
      prefix = "[FILTER]: ",
      always_show_folders = true,
    },
    log = {
      enable = false,
      truncate = false,
      types = {
        all = false,
        config = false,
        copy_paste = false,
        diagnostics = false,
        git = false,
        profile = false,
        watcher = false,
      },
    },
}

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
