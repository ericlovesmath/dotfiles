# Eric Lee's Dotfiles

![Neovim Configuration](bin/img/neovim.png)
![Firefox and Dock Configuration](bin/img/firefox.png)

## Overview of Dotfiles:

- Personalized for MacOS using [yabai](https://github.com/koekeishiya/yabai) + [skhd](https://github.com/koekeishiya/skhd) + [karabiner-elements](https://karabiner-elements.pqrs.org/)
- [Neovim](https://github.com/neovim/neovim) configuration, optimized for startup time
- [Alacritty](https://github.com/alacritty/alacritty) with zsh + [powerlevel10k](https://github.com/romkatv/powerlevel10k) prompt
- Dotfiles symlinked & applications installed with nix-darwin and home-manager

## Installation:

- Install [Nix](https://nixos.org/download/)

    - If Nix is not an option, see contents of nix flake to see proper symlinks

- `> mkdir ~/dotfiles & cd ~/dotfiles`
- `> git clone https://github.com/ericlovesmath/dotfiles.git ~/dotfiles`
- `> nix run nix-darwin -- switch --flake ~/dotfiles\#macos`

## General Style

- Yabai: Tiling WM uses Capslock as a `meh/hyper` global prefix, mimicking vim keybindings
- Neovim: `Lazy` to install packages, `Mason` to install LSPs
- Alacritty: Keybindings set such that intuitive `cmd + _` key combinations works with `tmux`
- Nix: Currently only used as a declarative package manager and symlink-er
