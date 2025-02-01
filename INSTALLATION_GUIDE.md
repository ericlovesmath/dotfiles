# Installation / Configuration Guide

- The guide is specifically for Fedora on the AMD Framework 13

    - MacOS configuration is done through `nix-darwin` in its entirety
    - This is mostly just for personal reference

- Fedora is Non-NixOS, so any needed `systemctl` for example are documented here

## General Installation

- [Official Framework Guide](https://guides.frame.work/Guide/Fedora+40+Installation+on+the+Framework+Laptop+13/328)

    - Setup Fedora Workstation with fingerprint reader
    - Update BIOS and Firmware as needed
    - Set battery limit in BIOS [F2 > Advanced > Battery Limit 85%]

- Multimedia Codecs: `sudo dnf group install multimedia`
- Uninstall Firefox: `sudo dnf remove firefox`
- Keyboard Language: `sudo dnf install fcitx5 fcitx5-hangul fcitx5-chinese-addons fcitx5-mozc`
- Use ppd instead of tuned (for AMD): `sudo dnf swap tuned-ppd power-profiles-daemon`

## Nix

- Install nix through [Determinate Nix Installer](https://github.com/DeterminateSystems/nix-installer)

    - ZSH: `chsh -s $(which zsh)` (may need need to add to `/etc/shells`

- Kanata Configuration: https://github.com/jtroo/kanata/wiki/Avoid-using-sudo-on-Linux
- Solaar Configuration: https://pwr-solaar.github.io/Solaar/rules

## Hyprland

Note: Hyprland's `exec-once` acts as `systemctl` replacements as well. If not using Hyprland, make `systemctl`s for `kanata`, `thunderbird`, and `protonmail-bridge`.

```bash
sudo dnf install dnf-plugins-core
sudo dnf copr enable solopasha/hyprland
sudo dnf install Hyprland hyprlock
```

- Note that Hyprland can probably be installed with a custom `systemctl` through Nix. I could not figure it out. Let me know if you do.
- `hyprlock` can also be installed with Nix fine, I just don't know enough about `/etc/pam.d` to care
- `hyprland.conf` may have manual `$HOME` paths set that need to be modified

## Manual Configuration Needed?

- Audio Level (Set to 50% for Framework laptop)

## TODO

- Install [Easy Effects](https://github.com/FrameworkComputer/linux-docs/tree/main/easy-effects#for-fedora-users-on-their-framework-laptop-13)

    - curl https://raw.githubusercontent.com/FrameworkComputer/linux-docs/main/easy-effects/Fedora-easy-effects-13-installer.sh | bash

- AirMessage / BlueBubble
- Spotifyd / spotify-player (When OAuth is fixed)
- Sound effects on key presses
- Hyprlock on sleep or laptop close
- Force Todoist to open in one tab only and in the right workspace on startup
