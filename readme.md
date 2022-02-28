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

This project is actually growing! I'm stoked!! Lets chat about it and discuss it's furlture:
https://discord.gg/9tZq3WrU4p


## Dependencies:

### Windows:

Simply use the `--deps` flag on the installer and it will automaticallt get all your dependencies for you! Still, if you prefer to do that sort of thing yourself, check below:

Make sure to enable developer mode.

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

cd into the Neovide install directory, and simply run `./NeoCodeInstaller<yoursystem> --install-packer`

If running Windows (other systems to come VERY soon) then also add the `--deps` flag to have the installer grab scoop package manager and download everything you need for this config.

The install will be automatic and headlessly install all the needed plugins.

I just released the binaries today for Windows and Linux, please let me know if there are any issues with them!

## FAQ

- How do I get language support for a certian language?
type `:LspInstall` while the file is open and it should find a language server for you.

- How do I get syntax support for a language?
type `TSInstall ` and press `<tab>` and you will get an autocomplete window of available parsers.

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
* **Rename Symbol:**
`F2`

### UI Navigation

* **Popup Terminal:**
`ctrl + \` will give you a floating terminal that you can run commands in
* **Switch Tabs:**
`gt` and `gy` OR `shift+h` and `shift+y`
* **Jump up or down by pages:**
`shift+j` and `shift+k`
* **Switch Windows:**
`ctrl+w then h,j,k, or l`
* **close buffer/tab:**
`qb`
* **Quick-exit Insert Mode:**
`qq`

## TODO:
- [x] Set Neovide multigrid env var in installer script
- [ ] Have the installer install NERD front automatically (cross platform)
- [ ] (maybe) ship Neovide binary inside the installer to futher simplify the setup
- [ ] Set list of default installed language servers and treesitter parsers
