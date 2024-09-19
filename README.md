# Setting Up

## Windows

For Windows, I haven't tested the installation recently but the primary points are as follows:

### Dependencies

- Neovim 10+ (ideally latest version, can be installed however)

- Nerd Font (Jet Brains Mono)

- Msys2 (`choco install msys2`)

- LLVM (`choco install llvm`)

- Python3 - make sure to `pip install pynvim` (after `choco install python`)

- Luarocks (`choco install luarocks`)

- fd or ripgrep (`choco install fd` or `choco install ripgrep`)

- Node (`choco install nodejs`)

- Neovide

### Set Up

First, you want to clone this repo into `%localappdata%/nvim`.

Next, the config *should* handle bootstrapping lazy.nvim as well as the plugins.

After it is working, run `:MasonInstallAll` to install some dependencies.

## Linux

While this may be a lot easier, I also haven't paid a lot of attention to how I set it up on Linux. I will try to add some highlights for it but let it be noted that there may be a number of missed steps (primarily installs) that you will have to handle yourself (though it should be fairly easy and straightforward).

### Dependencies

- Neovim 10+

- Nerd Font (Roboto Mono NerdFont)

- Python3

- Luarocks

- C++ Compiler (perhaps gcc?)

- Ripgrep or fd

### Set Up

Clone this repo into `~/.config/nvim`

# Credits

Credit to NvChad for the starter (file structure, lots of code).
