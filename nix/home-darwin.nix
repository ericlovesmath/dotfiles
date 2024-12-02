{ config, pkgs, ... }:

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
    ".yabairc".source = ../.yabairc;
  };
}
