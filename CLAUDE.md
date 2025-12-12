# CLAUDE.md

This file provides guidance to Claude Code (claude.ai/code) when working with code in this repository.

## Project Overview

NeoCode is a Neovim configuration designed to replicate the out-of-box experience of VS Code for users transitioning from traditional editors. The config aims to be an "install-and-code" solution that requires minimal manual configuration.

## Installation and Setup

The installer (`installer.py`) handles all dependencies and setup automatically:

```bash
python installer.py
```

The installer:
- Auto-detects OS (Windows: `~/AppData/Local/nvim`, Linux/Mac: `~/.config/nvim`)
- Backs up existing Neovim configs (as `nvim.backup`, `nvim.backup.1`, etc.)
- Creates symlink from `nvim-config/` directory to the appropriate config location
- Installs dependencies (varies by OS)

**Important**: The repo must remain in place after installation since it symlinks rather than copies.

## Architecture

### Configuration Loading Flow

1. `nvim-config/init.lua` - Entry point that orchestrates loading
2. VS Code mode detection: Uses `vim.g.vscode` to conditionally load features
3. Module loading order:
   - Core: `packer-config`, `settings`, `keymap`, `visual`, `lsp`, `autocommands`
   - Syntax: `plugins.syntax.treesitter`
   - Editor: Plugins for editing features (autopairs, project management, etc.)
   - UI: Plugins for visual elements (statusline, file tree, etc.)

### Plugin Management

Uses **Packer.nvim** (`packer-config.lua`):
- Auto-installs itself on first run via `ensure_packer()`
- Runs `packer sync` automatically on bootstrap
- Plugin definitions in `packer-config.lua`

### LSP Architecture

LSP setup in `nvim-config/lua/lsp/init.lua`:
- Uses **Mason** for LSP server management (replaces old lsp-installer)
- **mason-lspconfig** handles automatic installation
- Default servers: `lua_ls`, `rust_analyzer`, `ts_ls`, `cssls`, `eslint`, `html`, `marksman`, `jdtls`, `gdscript`
- Custom handlers for specific servers (rust_analyzer, gdscript, pyright, lua_ls)
- **nvim-navbuddy** attaches to every LSP server for breadcrumb navigation
- **null-ls** handles formatting (stylua, prettier)
- Completion config in `lsp/cmp.lua`

### Module Organization

```
nvim-config/
├── init.lua                 # Main entry point
└── lua/
    ├── packer-config.lua    # Plugin manager setup
    ├── settings.lua         # Core Vim settings
    ├── keymap.lua           # Keybindings
    ├── visual.lua           # Theme/colorscheme
    ├── autocommands.lua     # Autocommands
    ├── neovide.lua          # GUI wrapper settings
    ├── update-checker.lua   # Checks for NeoCode updates
    ├── icons.lua            # Icon definitions
    ├── lsp/
    │   ├── init.lua         # LSP configuration
    │   └── cmp.lua          # Completion setup
    └── plugins/
        ├── editor/          # Editor feature plugins
        ├── syntax/          # Treesitter config
        └── ui/              # UI component plugins
```

### Key Design Patterns

1. **Protected calls**: Most module loading uses `pcall()` to gracefully handle missing plugins
2. **Separate config files**: Each plugin gets its own config file (except simple ones configured in init.lua)
3. **VS Code compatibility**: Config detects `vim.g.vscode` and loads minimal subset for VS Code Neovim plugin
4. **User customization**: Reserved `user/` directory (not tracked by git) for custom configs

### User Custom Configuration

The config supports user customization through `lua/user/` directory (gitignored):
- `user/init.lua` - Entry point for custom configs
- `user/customplugins.lua` - Returns table of additional packer plugins
- `user/keybinds.lua` - Custom keybindings
- `user/settings.lua` - Custom settings

Custom configs load last, allowing overrides without git conflicts.

## Development Commands

### Testing Configuration Changes

```bash
# Open Neovim to test config
nvim

# Force Packer to sync plugins after changes
nvim -c "PackerSync"
```

### Installing Language Support

```vim
" Install language server (opens picker)
:LspInstall

" Install Treesitter parser
:TSInstall <language>

" View available parsers
:TSInstall <tab>
```

### Plugin Management

```vim
" Sync plugins (install, update, clean)
:PackerSync

" Install missing plugins
:PackerInstall

" Update plugins
:PackerUpdate

" Clean removed plugins
:PackerClean
```

## Important Configuration Notes

### Leader Key

Leader key is **comma (`,`)** - not the default backslash.

Example: `<leader><leader>c` means press `,` twice then `c`.

### Keybinding Layers

Keybindings are split across multiple files:
- `keymap.lua` - Base keymaps (Telescope, commenting, terminal)
- `lsp/init.lua` - LSP-specific mappings (prefixed with `<space>`)
- `plugins/ui/legendary.lua` - Additional keybinds discoverable via command palette

**LSP mappings use `<space>` prefix** (not leader):
- `<space>d` - Go to definition
- `<space>rn` - Rename symbol
- `<space>ca` - Code action
- `<space>f` - Format document

### Critical Default Servers

When modifying LSP config, these servers are expected by default:
- `lua_ls` (with vim globals configured)
- `ts_ls` (renamed from tsserver)
- `rust_analyzer`
- `gdscript` (Godot support)

### Treesitter Configuration

Treesitter auto-installs on plugin sync. Config in `plugins/syntax/treesitter.lua` specifies default parsers.

### Terminal Integration

Uses **nvzone/floaterm** (replaced toggleterm):
- Toggle: `Ctrl + ~` (backtick)
- Configured in `plugins/editor/floatterm.lua`

### File Navigation

- File tree: **neo-tree** (`plugins/editor/neotree.lua`) - replaced nvim-tree
- Fuzzy finder: **Telescope** (`plugins/ui/telescope.lua`)
- Project management: **project.nvim** and **workspaces.nvim**

## Modifying This Config

### Adding a New Plugin

1. Add to `packer-config.lua` in the `use()` block
2. Create config file in appropriate `plugins/` subdirectory
3. Require the config in `init.lua`
4. Run `:PackerSync` in Neovim

### Changing LSP Servers

Edit `ensure_installed` table in `lsp/init.lua`:

```lua
require("mason-lspconfig").setup({
    ensure_installed = { "lua_ls", "rust_analyzer", ... },
    ...
})
```

### Switching Themes

Edit `visual.lua` to change colorscheme. Multiple themes are installed (catppuccin, gruvbox, moonlight, dracula, vscode, etc.).

### Modifying Keybindings

- Basic keymaps: Edit `keymap.lua`
- LSP keymaps: Edit `lsp/init.lua` on_attach function
- Command palette entries: Edit `plugins/ui/legendary.lua`

## Testing Changes

After making configuration changes:

1. Restart Neovim or `:source %` if editing a lua file
2. Run `:PackerSync` if plugin changes were made
3. Check `:checkhealth` for any issues
4. Use `:Legendary` (Ctrl+k) to discover available commands

## Common Issues

- **Packer not found**: First run will auto-install and require restart
- **LSP not working**: Run `:LspInstall` while file is open
- **Symlink issues**: Installer must be run from repo directory
- **Missing dependencies**: Re-run `installer.py`
