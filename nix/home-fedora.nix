{ nixgl }:
{ config, pkgs, lib, ... }:

let
  firefoxProfile = ".mozilla/firefox/nixprofile";
in
{
  imports = [ ./home-shared.nix ];

  home.homeDirectory = "/home/ericlee";

  # Make Nix apps show in various DEs
  targets.genericLinux.enable = true;
  xdg.enable = true;
  xdg.mime.enable = true;
  xdg.systemDirs.data = [ "${config.home.homeDirectory}/.nix-profile/share/applications" ];
  xdg.mimeApps = {
    enable = true;
    defaultApplications = {
      "application/pdf" = ["zathura.desktop" "org.gnome.Evince.desktop" "firefox.desktop"];
      "x-scheme-handler/http" = "firefox.desktop";
    };
  };
  
  nixpkgs.config.allowUnfree = true;

  nixGL = {
    packages = nixgl.packages;
    defaultWrapper = "mesa";
  };

  home.packages =
    with pkgs;
    [
      gcc gnumake unrar kanata qemu_kvm virt-manager
      protonmail-bridge protonvpn-cli_2 zotero libreoffice
      gimp solaar everest-mons transmission_4 lunar-client
      thunderbird-bin meslo-lgs-nf aseprite zathura
      spotify-player spotifyd tesseract ydotool libqalculate
      swww rofi-wayland mako grim slurp hypridle
      networkmanager bluez bluez-tools blueman pavucontrol
      ollama godot_4 realvnc-vnc-viewer cryptomator
    ] ++
    (builtins.map config.lib.nixGL.wrap [
      waybar
      obs-studio slack steam spotify mpv
      signal-desktop webcord alacritty
      jellyfin-media-player
    ]);

  home.file = {
    "${firefoxProfile}/chrome".source = ../firefox/chrome;
    "${firefoxProfile}/user.js".source = ../firefox/user.js;

    ".config/hypr".source = ../hypr;
    ".config/waybar".source = ../waybar;
    ".config/rofi/config.rasi".source = ../rofi.rasi;
    ".config/mako/config".source = ../mako.cfg;
  };

  programs.firefox = {
    enable = true;
    package = (config.lib.nixGL.wrap pkgs.firefox);
    profiles.nixprofile = {
      search = {
        engines = {
          "Kagi" = {
            urls = [{
              template = "https://kagi.com/search";
              params = [ { name = "q"; value = "{searchTerms}"; } ];
            }];
            iconUpdateURL = "https://assets.kagi.com/v1/kagi_assets/logos/yellow_3.svg";
            updateInterval = 24 * 60 * 60 * 1000; # Daily
            definedAliases = [ "@kagi" ];
          };
        };
        default = "Kagi";
        privateDefault = "DuckDuckGo";
        force = true;
      };

      # https://wiki.archlinux.org/title/Firefox#Hardware_video_acceleration
      settings = {
        "layers.acceleration.force-enabled" = true;
        "media.ffmpeg.vaapi.enabled" = true;
        "gfx.webrender.all" = true;
        "webgl.force-enabled" = true;
        "media.hardware-video-decoding.force-enabled" = true;
      };
    };
  };
}
