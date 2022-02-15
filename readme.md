# Neocode
Sane, simple, and effective config dedicated to replicating vscode in Neovim.

Installer works for:
  - (most) linux distros
  - Windows 10/11
  - Mac OSX

## Dependencies:

Telescope FZF Native:
```choco install mingw```
```choco install make```

Neovim Nightly:
```scoop install neovim-nightly```

Neovide (reccomended):
https://github.com/neovide/neovide

Rust Lang:
https://www.rust-lang.org/tools/install

## Instructions
Clone this repo somewhere easy to access on your pc. For example, I use ~\Code.

cd into the Neovide installe directory, and simply run cargo run -- --install_packer

The install will be automatic and headlessly install all the needed plugins.
