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
- Consider using `ppd` instead of `tuned` (for AMD): `sudo dnf swap tuned-ppd power-profiles-daemon`

    - It was not an improvement for me

- Turn down Mic input to ~50%

## Nix

- Install nix through [Determinate Nix Installer](https://github.com/DeterminateSystems/nix-installer)

    - ZSH: `chsh -s $(which zsh)` (may need need to add to `/etc/shells`

- Solaar Configuration: https://pwr-solaar.github.io/Solaar/rules

## keyd

- Keyboard Daemon, simple Vim and Firefox bindings

    - Nix on Fedora can't manage `/etc`, manual configuration

```bash
sudo dnf copr enable alternateved/keyd
sudo dnf install keyd
sudo systemctl enable --now keyd
```

Contents of `/etc/keyd/default.conf`:

```toml
[ids]
*

[main]
capslock = overload(capslock, esc)
leftalt = leftmeta
leftmeta = leftalt
esc = `

[capslock:C]
1 = C-S-tab
2 = C-S-pageup
3 = C-S-pagedown
4 = C-tab
```

```bash
sudo keyd reload
```

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

## SwayWM

- `sudo dnf install sway`
- Launching from `tty` instead of GDM is suggested, not sure why, seems fine either way

## Virtualisation (QEMU + KVM + virt-manager)

```bash
grep -cE '(vmx|svm)' /proc/cpuinfo  # Verify cores exist (> 0)
sudo dnf install @virtualization    # Don't want to bother with Nix issues
sudo usermod -aG libvirt $USER
sudo usermod -aG kvm $USER
sudo systemctl enable libvirtd
sudo systemctl start libvirtd
sudo systemctl status libvirtd
virt-manager
```

## TODO

- Install [Easy Effects](https://github.com/FrameworkComputer/linux-docs/tree/main/easy-effects#for-fedora-users-on-their-framework-laptop-13)

    - curl https://raw.githubusercontent.com/FrameworkComputer/linux-docs/main/easy-effects/Fedora-easy-effects-13-installer.sh | bash

- AirMessage / BlueBubble
- Spotifyd / spotify-player (When OAuth is fixed)
- Sound effects on key presses
- Hyprlock on sleep or laptop close
