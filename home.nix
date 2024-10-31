{ config, pkgs, ... }:

let
  firefoxApp = "Applications/Firefox.app/Contents/Resources";
  firefoxProfile = "Library/Application Support/Firefox/Profiles/wwpdd487.default-release";
in
{
  home.username = "ericlee";
  home.homeDirectory = "/Users/ericlee";
  home.stateVersion = "24.11";

  # Makes sense for user specific applications that shouldn't be available system-wide
  # home.packages = with pkgs; [ ];

  # Home Manager is pretty good at managing dotfiles. The primary way to manage
  # plain files is through 'home.file'.
  home.file = {
    ".tmux.conf".source = ./.tmux.conf;
    ".config/nvim".source = ./nvim;
    ".config/borders/bordersrc".source = ./bordersrc;
    ".config/sketchybar".source = ./sketchybar;
    ".config/skhd/skhdrc".source = ./skhdrc;
    ".config/alacritty/alacritty.toml".source = ./alacritty.toml;
    ".config/karabiner".source = ./karabiner;
    ".aerospace.toml".source = ./.aerospace.toml;
    ".latexmkrc".source = ./.latexmkrc;
    ".yabairc".source = ./.yabairc;
    ".zshrc".source = ./.zshrc;

    "${firefoxProfile}/startpage".source = ./firefox/startpage;
    "${firefoxProfile}/chrome".source = ./firefox/chrome;
    "${firefoxProfile}/user.js".source = ./firefox/user.js;

    # 1. Edit mozilla.cfg to put the location of the startpage
    # 2. Update [Betterfox](https://github.com/yokoffing/Betterfox)

    # Newtab Loader
    "${firefoxApp}/mozilla.cfg".source = ./firefox/mozilla.cfg;
    "${firefoxApp}/defaults/pref/local-settings.js".source = ./firefox/local-settings.js;
  };

  programs.home-manager.enable = true;
}
