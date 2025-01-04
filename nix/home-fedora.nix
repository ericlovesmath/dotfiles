{ nixgl }:
{ config, pkgs, lib, ... }:

let
  firefoxProfile = ".mozilla/firefox/nixprofile";
in
{
  imports = [ ./home-shared.nix ];

  home.homeDirectory = "/home/ericlee";

  # Make Nix apps show in GNOME
  targets.genericLinux.enable = true;
  xdg.mime.enable = true;
  xdg.systemDirs.data = [ "${config.home.homeDirectory}/.nix-profile/share/applications" ];
  
  nixpkgs.config.allowUnfree = true;

  nixGL = {
    packages = nixgl.packages;
    defaultWrapper = "mesa";
  };

  home.packages = with pkgs; [
    gcc gnumake unrar kanata powertop
    discord spotify slack ollama kmonad
    protonmail-bridge protonvpn-gui zotero libreoffice
    gimp solaar everest-mons transmission_4 lunar-client
    thunderbird-bin meslo-lgs-nf
    spotify-player spotifyd
    waybar wofi mako
    (config.lib.nixGL.wrap alacritty)
    (config.lib.nixGL.wrap mpv)
    (config.lib.nixGL.wrap obs-studio)
    (config.lib.nixGL.wrap steam)
  ];

  home.file = {
    "${firefoxProfile}/chrome".source = ../firefox/chrome;
    "${firefoxProfile}/user.js".source = ../firefox/user.js;
  };

  programs.firefox = {
    enable = true;
    package = pkgs.firefox;
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
    };
  };
  
  # TODO: KVM
  # Need to add desktop to Gnome Login
  # https://gist.github.com/AntonFriberg/1dcb1ee6bf2c92c5f641a6f764d582d9
  # wayland.windowManager.hyprland = {
  #   enable = true;
  #   package = config.lib.nixGL.wrap pkgs.hyprland;
  #   settings = {
  #     general = {
  #       gaps_in = 0;
  #       gaps_out = 0;
  #       border_size = 20;
  #     };
  #   };
  # };
}
