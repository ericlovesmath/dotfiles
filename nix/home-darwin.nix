{ config, pkgs, lib, ... }:

let
  # TODO: This isn't working because thats the home path
  firefoxProfile = "Library/Application Support/Firefox/Profiles/0lcdwvwo.default-release";
  # firefoxApp = "Applications/Firefox.app/Contents/Resources";
in
{
  imports = [ ./home-shared.nix ];

  home.packages = with pkgs; [
    skhd yabai sketchybar jankyborders
    meslo-lgs-nf font-awesome
  ];

  home.file = {
    ".config/borders/bordersrc".source = ../bordersrc;
    ".config/sketchybar".source = ../sketchybar;
    ".config/skhd/skhdrc".source = ../skhdrc;
    ".config/karabiner".source = ../karabiner;
    ".aerospace.toml".source = ../.aerospace.toml;
    ".yabairc".source = ../.yabairc;

    "${firefoxProfile}/startpage".source = ../firefox/startpage;
    "${firefoxProfile}/chrome".source = ../firefox/chrome;
    "${firefoxProfile}/user.js".source = ../firefox/user.js;

    # TODO: Firefox
    # Firefox Extensions: Auto Tab Discard, Bitwarden, Bypass Paywalls Clean,
    # Dark Reader, Forest, h254ify, OneTab, Return Youtube Dislike, Sidebery,
    # SponserBlock, Tweaks for YouTube, uBlock Origin, Zotero Connector.

    # 1. Edit mozilla.cfg to put the location of the startpage
    # 2. Update [Betterfox](https://github.com/yokoffing/Betterfox)

    # Newtab Loader
    # "${firefoxApp}/mozilla.cfg".source = ./firefox/mozilla.cfg;
  };

  programs.firefox = {
    enable = true;
    package = pkgs.firefox-bin;
  };

  # Hack to link NixOS Application to be searchable on MacOS
  home.activation = {
    rsync-home-manager-applications = lib.hm.dag.entryAfter [ "writeBoundary" ] ''
      rsyncArgs="--archive --checksum --chmod=-w --copy-unsafe-links --delete"
      apps_source="$genProfilePath/home-path/Applications"
      moniker="Home Manager Trampolines"
      app_target_base="${config.home.homeDirectory}/Applications"
      app_target="$app_target_base/$moniker"
      mkdir -p "$app_target"
      ${pkgs.rsync}/bin/rsync $rsyncArgs "$apps_source/" "$app_target"
    '';
  };
}