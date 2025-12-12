![logo](neocode.png)

# Neocode
  Sane, simple, and effective config dedicated to replicating the out-of-box experience of vscode in Neovim.

There are many, many good Vim configs out there...many in which are better than this one. **BUT** I feel that the biggest barrier of entry for users switching from more traditional editors is the configuration. Who wants to spend hours and hours working on a config when VS code just fires up and is ready to go? Well...me...but not everyone is like me! This config is made to be a install-and-code config. Just clone the repo, run the installer, and you're ready to code!

The config was made to be a simple as possible. I think any setting you could need to change would be found right where you expect it to be.

![show-off](newcode-new-new.gif)
NeoCode with it's new Catppuccin look running in Neovide using the multigrid flag for
fancy animations

Installer works for:
  - The following Linux Distros:
	  - Ubuntu
	  - Fedora
  - Windows 10/11
  - Mac OSX

## Community

This project is actually growing! I'm stoked!! Join the [Discord](https://discord.gg/9tZq3WrU4p)


## Dependencies:

The new installer script should manage/download all dependencies automatically now. You no longer need to install deps manually.


## Instructions

1. Clone/Download repo to somewhere on your PC. The config will need to remain where it's placed after installation, so place it somewhere you don't mind it living!
2. enter the directory where you downloaded the repo using your terminal/console and run the python installer file using `python installer.py`
3. watch as the installer does **everything** for you

## FAQ

- How do I get language support for a certian language?
type `:LspInstall` while the file is open and it should find a language server for you.

- How do I get syntax support for a language?
type `TSInstall ` and press `<tab>` and you will get an autocomplete window of available parsers.

## How to add custom configuration

The setup is now capable of using custom code without it getting overridden when syncing newest
changes. The user's custom config folder should be located under the lua folder, called
`user`. Inside the user folder there should be an init.lua file, as well as 
customplugins.lua, keybinds.lua and settings.lua files. The contents of the file should be as follows:

customplugins.lua:
```
-- put your custom lua plugins in this lua table to be loaded last by packer
return {
  "rebelot/kanagawa.nvim",
  "windwp/windline.nvim"
}
```

customplugins is just a list of packer repos that you want to be sourced after the plugin defaults.

init.lua
```
-- use pcalls in this file to require custom config files,
-- that way if anyone syncs the repo and doesn't have that file they won't get errors

local plugin_okay, plugin = pcall(require, "user.<customFileName>")
if not custom_okay then
  return
end
```

Inside init.lua, you'll call any custom LUA files that you've written. For example, if you wanted a
custom theme, just make a copy of visual.lua, place it in user folder, and require it inside
of init.lua. At the end of the plugin loading of the main init.lua, it will call all of your custom
configs. These files are not tracked by git and therefor will persist even when you grab the newest
updates from the github repo!

## Commonly Used Keybinds:

> leader key refers to the comma ( , ) key on your keyboard!

### VS Code Features:

* **Command Pallete:**
I can't use crtl+shift+p as keybind in vim, so the command pallette is used with `crtl+k`
* **Quick Open:**
Quick open is used to quickly open files in a directory. Call it with `crtl-p`.
* **Sidebar Toggle:**
Vim doesn't have a sidebar to hold differnt features. We'll use `crtl+b` to open the Filetree as a sidebar.
* **Commenting / Uncommenting:**
Use `<leader><leader>c` to comment a line or multiple lines. The leader key is the , key on your keyboard. So the key chord would be `,,c`.
* **Show Symbols:**
Press `ctrl+o` to view the symbols sidebar. This lets you browse code by the functions, essentially.
* **Global Find / Find in Project**
This feature is mapped to `<leader><leader>g` the G is for "live-**G**rep". Grep is a term that vimmers use to say searching, basically.
* **Indent / Unindent Lines:**
Use the `<` and `>` keys to indent and un-indent text.
* **Search open buffers:**
Use `<leader><leader>b` to search and quickly open an already open buffer.
* **Formating Documents:**
Use `<leader><leader>f` to auto-format a document using the language server.
* **move to next / prev diagnostic**: 
Use `[d` or `]d`.

### LSP Commands

Most lsp command (command pertaining to the language server) are prefixed with the space key instead of the leader
key for memoralibilitys sake

* **Rename Symbol:**
`F2` or `space-rn`
* **Format Buffer/Document**
`space-f`
* **Perform Code Action**
`space-ca`
* **Goto Definition**
`space-d`
* **Goto Declaration**
`space-D`
* **Signature Help**
`ctrl-i`

### UI Navigation

* **Return to Dashboard**
`<leader><leader>h`
* **Popup Terminal:**
`ctrl + ~` (the tilde key without shift) will give you a floating terminal that you can run commands in
* **Switch Tabs:**
`gt` and `gy` OR `shift+h` and `shift+l`
* **Close Tabs:**
* the close tab button has been removed, if using a mouse please use right-click to close an open tab
* **Jump up or down by pages:**
`shift+j` and `shift+k`
* **Switch Windows:**
`ctrl+w then h,j,k, or l`
* **close buffer/tab:**
`qb`
* **Quick-exit Insert Mode:**
`qq`

#### Terminal Mappings
This are the mappings for sidebar

`a` -> add new terminal
`e` -> edit terminal name
Pressing any number within sidebar will switch to that terminal
Must be pressed in main terminal buffer

`Ctrl + h` -> Switch to sidebar
`Ctrl + j` -> Cycle to prev terminal
`Ctrl + k` -> Cycle to next terminal

### VS Code Support
This configuration now supports being ran inside VS Code itself via the "Neovim VS Code Plugin".

When using the configuation inside VS Code it just uses keybinds, legendary, and settings.lua. Still makes for a pretty seamless experience when compared with VS Code native features IMO. More VS Code keybinds to come soon!

Due to limitations of running Neovim inside VS Code, we can't have fuzzy finders and whatnot render, so you'll need to use the VS Code counterparts (such a ctrl+p and strl+shift+p)

## TODO:
- [ ] Set Neovide multigrid env var in installer script
- [ ] Have the installer install NERD front automatically (cross platform)
- [ ] Improve documentation
- [x] Set list of default installed language servers and treesitter parsers ✅ 2024-07-19
- [X] Integrate more VS-code keybinds to make transition easier for newbies