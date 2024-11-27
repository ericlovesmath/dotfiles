{ config, pkgs, ... }:

{
  imports = [ ./home-shared.nix ];

  # TODO: meslo-lgs-nf?
  home.packages = with pkgs; [
    skhd yabai sketchybar jankyborders
  ];

  home.file = {
    ".config/borders/bordersrc".source = ../bordersrc;
    ".config/sketchybar".source = ../sketchybar;
    ".config/skhd/skhdrc".source = ../skhdrc;
    ".yabairc".source = ../.yabairc;
  };
}
