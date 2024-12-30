# NOTE: This is an untested baseline config

{ config, pkgs, lib, ... }:
{
  imports = [ ./home-shared.nix ];

  home.homeDirectory = "/home/ericlee";

  home.packages = with pkgs; [
    alacritty thunderbird mpv discord zoom spotify firefox slack
    steam protonmail-bridge protonvpn-gui minecraft zotero libreoffice
    gimp solaar
  ];

  # Need to add desktop to Gnome Login
  # https://gist.github.com/AntonFriberg/1dcb1ee6bf2c92c5f641a6f764d582d9
  wayland.windowManager.hyprland = {
    enable = true;
    package = config.lib.nixGL.wrap pkgs.hyprland;
    settings = {
      general = {
        gaps_in = 0;
        gaps_out = 0;
        border_size = 20;
      };
    };
  };

  # TODO: KVM?

  # nixGL Wrapper
  # programs = {
  #   alacritty.package = config.lib.nixGL.wrap pkgs.alacritty;
  # };

}
