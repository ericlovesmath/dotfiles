{ nixgl }:
{ config, pkgs, lib, ... }:

let
  firefoxProfile = ".mozilla/firefox/nixprofile";
  mkFirefoxAddons = addons :
    let
      mkAddon = { id, name, private ? false, extraConfig ? {} }: {
        "${id}" = {
          install_url = "https://addons.mozilla.org/firefox/downloads/latest/${name}/latest.xpi";
          installation_mode = "force_installed";
          allowed_in_private_browsing = private;
        } // extraConfig;
      };
    in
    builtins.foldl' (acc: addon: acc // mkAddon addon) {} addons;
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
      spotify-player spotifyd tesseract libqalculate
      swww rofi-wayland mako grim slurp hypridle
      networkmanager bluez bluez-tools blueman pavucontrol
      ollama godot_4 realvnc-vnc-viewer cryptomator copyq
    ] ++
    (builtins.map config.lib.nixGL.wrap [
      waybar obs-studio slack steam spotify mpv
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

      settings = {
        # https://wiki.archlinux.org/title/Firefox#Hardware_video_acceleration
        "layers.acceleration.force-enabled" = true;
        "media.ffmpeg.vaapi.enabled" = true;
        "gfx.webrender.all" = true;
        "webgl.force-enabled" = true;
        "media.hardware-video-decoding.force-enabled" = true;

        # LibreWolf specific
        # "toolkit.legacyUserProfileCustomizations.stylesheets" = true
        # "privacy.clearOnShutdown.history" = false;
      };
    };

    # policies = {
    #   Containers = {
    #     Default = [
    #      {
    #        name = "YouTube";
    #        icon = "circle";
    #        color = "red";
    #      }
    #    ];
    #   };
    #   ContainersAutoAssign = {
    #     "youtube.com" = "YouTube";
    #   };
    # };

    policies.ExtensionSettings = mkFirefoxAddons [
      { name = "ublock-origin";                  id = "uBlock0@raymondhill.net";                private = true; }
      { name = "bitwarden-password-manager";     id = "{446900e4-71c2-419f-a6a7-df9c091e268b}"; private = true; }
      { name = "darkreader";                     id = "addon@darkreader.org"; }
      { name = "auto-tab-discard";               id = "{c2c003ee-bd69-42a2-b0e9-6f34222cb046}"; }
      { name = "kagi-privacy-pass";              id = "privacypass@kagi.com"; }
      { name = "sidebery";                       id = "{3c078156-979c-498b-8990-85f7987dd929}"; }
      { name = "sponsorblock";                   id = "sponsorBlocker@ajay.app"; }
      { name = "tweaks-for-youtube";             id = "{84c8edb0-65ca-43a5-bc53-0e80f41486e1}"; }
      { name = "forest-stay-focused-be-present"; id = "@forest-firefox-addon"; }
      { name = "return-youtube-dislikes";        id = "{762f9885-5a13-4abd-9c77-433dcd38b8fd}"; }
      { name = "multi-account-containers";       id = "@testpilot-containers"; }
    ];
  };
}

