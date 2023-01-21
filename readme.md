![logo](neocode.png)

# Neocode
  Sane, simple, and effective config dedicated to replicating the out-of-box experience of vscode in Neovim.

There are many, many good Vim configs out there...many in which are better than this one. **BUT** I feel that the biggest barrier of entry for users switching from more traditional editors is the configuration. Who wants to spend hours and hours working on a config when VS code just fires up and is ready to go? Well...me...but not everyone is like me! This config is made to be a install-and-code config. Just clone the repo, run the installer, and you're ready to code!

The config was made to be a simple as possible. I think any setting you could need to change would be found right where you expect it to be.

![show-off](showoff.gif) / ! [](showoff.gif)

Installer works for:
  - (most) linux distros
  - Windows 10/11
  - Mac OSX

## Community

This project is actually growing! I'm stoked!! Lets chat about it and discuss it's future:
https://discord.gg/9tZq3WrU4p


## Dependencies:

### Windows:
Simply use the `--deps` flag on the installer and it will automaticallt get all your dependencies for you! Still, if you prefer to do that sort of thing yourself, check below:

Make sure to enable developer mode on Windows so the script can create the Symlink between the Config and your neovim folder.

Scoop package manager:
`iwr -useb get.scoop.sh | iex`

Ripgrep for Live-grepping (find in project)
`scoop install ripgrep`

FZF for file searching
`scoop install fzf`

Lazygit for working with git in the terminal
`scoop bucket add extras`
`scoop install lazygit`

Neovim Nightly:
`scoop bucket add versions`
`scoop install neovim-nightly`

### MacOS:

Simply use the --deps flag on the installer and it will automaticallt get all your dependencies for you! Still, if you prefer to do that sort of thing yourself, check below:

Make sure to enable developer mode.

Homebrew package manager:
`/bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"`

Ripgrep for Live-grepping (find in project)
`brew install ripgrep`

FZF for file searching
`brew install fzf`

Lazygit for working with git in the terminal
`brew install lazygit`

Neovim Nightly:
Instructions coming soon!

Neovide (reccomended):
https://github.com/neovide/neovide


## Instructions

clone this repo somewhere easy to access on your pc. For example, I use ~\Code.

cd into the Neovide install directory, and simply run `./NeoCodeInstaller<yoursystem> --deps --install-packer`

you can also pass the `--create-user` flag to have the script generate a user folder for you

If running Windows (other systems to come VERY soon) then also add the `--deps` flag to have the installer grab scoop package manager and download everything you need for this config.

The install will be automatic and headlessly install all the needed plugins.

I just released the binaries today for Windows and Linux, please let me know if there are any issues with them!

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

## State of project
This project is literally brand new, and I am working on it alone. Some things may not work, and I may not have all the dependecies listed as they should be...if something is missing, please let me know.

## Commonly Used Keybinds:

### VS Code Alternaitve Features:

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

### VS Code Support
This configuration now supports being ran inside VS Code itself via the "Neovim VS Code Plugin".

When using the configuation inside VS Code it just uses keybinds, legendary, and settings.lua. Still makes for
a pretty seamless experience when compared with VS Code native features IMO. More VS Code keybinds to come soon!

Due to limitations of running Neovim inside VS Code, we can't have fuzzy finders and whatnot render, so you'll need
to use the VS Code counterparts (such a ctrl+p and strl+shift+p)


### Coming Soon: GUI Installer
I'm working on ditching the CLI installer I've built currently in favor of a Tauri-powered web GUI to install Neocode
& it's deps as easy as possible. More info and preview to come shortly! 

## TODO:
- [ ] Set Neovide multigrid env var in installer script
- [ ] Have the installer install NERD front automatically (cross platform)
- [ ] (maybe) ship Neovide binary inside the installer to futher simplify the setup
- [X] Set list of default installed language servers and treesitter parsers
- [ ] Improve documentation
- [X] Integrate more VS-code keybinds to make transition easier for newbies
