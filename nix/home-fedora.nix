{ nixgl }:
{ config, pkgs, lib, ... }:
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
    gcc gnumake unrar kmonad
    discord spotify firefox slack ollama kmonad
    protonmail-bridge protonvpn-gui zotero libreoffice
    gimp solaar everest-mons transmission_4 lunar-client
    thunderbird-bin meslo-lgs-nf
    (config.lib.nixGL.wrap alacritty)
    (config.lib.nixGL.wrap mpv)
    (config.lib.nixGL.wrap obs-studio)
    (config.lib.nixGL.wrap steam)
    (config.lib.nixGL.wrap hyprland)
  ];
  
  # TODO: Minecraft, KVM
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
