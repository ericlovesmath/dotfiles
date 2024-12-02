{ config, pkgs, ... }:

let
  # TODO: This isn't working because thats the home path
  firefoxProfile = "Library/Application Support/Firefox/Profiles/0lcdwvwo.default-release";
  # firefoxApp = "Applications/Firefox.app/Contents/Resources";
in
{
  programs.home-manager.enable = true;
  home.username = "ericlee";
  home.homeDirectory = "/Users/ericlee";
  home.stateVersion = "24.11";

  home.packages = with pkgs; [
    neovim tmux
    ripgrep lazygit jq
    imagemagick htop fzf fd ffmpeg
    tree wget nmap croc curl rlwrap fastfetch
    spicetify-cli coq deno pandoc
    nasm pandoc yt-dlp glow hugo docker gh
    julia-bin slides maven openjdk opam
    micromamba texliveFull
    nodejs python3 coreutils
    ghc haskell-language-server
    zsh zsh-powerlevel10k
  ];

  home.file = {
    ".tmux.conf".source = ../.tmux.conf;
    ".config/nvim".source = ../nvim;
    ".config/alacritty/alacritty.toml".source = ../alacritty.toml;
    ".config/karabiner".source = ../karabiner;
    ".aerospace.toml".source = ../.aerospace.toml;
    ".latexmkrc".source = ../.latexmkrc;

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

  home.sessionVariables = {
    EDITOR = "nvim";
  };

  programs.fzf = {
    enable = true;
    enableZshIntegration = true;
  };

  programs.opam.enable = true;

  programs.zsh = {
    enable = true;
    enableCompletion = false;
    dirHashes = {
      jane      = "$HOME/Desktop/Important/Jane Street";
      caltech   = "$HOME/Desktop/Academics/Caltech/junior/fall-2024";
      tutor     = "$HOME/Desktop/Academics/Tutoring";
      surf      = "$HOME/Desktop/Academics/Caltech/sophmore/SURF";
      firefox   = "$HOME/Library/Application Support/Firefox/Profiles/wwpdd487.default-release";
      finance   = "$HOME/Desktop/Important/finance";
      portfolio = "$HOME/Desktop/Programming/portfolio-eric-lee";
      usaco     = "$HOME/Desktop/Programming/competitive-programming";
    };
    plugins = [{
      name = "zsh-powerlevel10k";
      src = "${pkgs.zsh-powerlevel10k}/share/zsh-powerlevel10k/";
      file = "powerlevel10k.zsh-theme";
    }];
    initExtra = ''
      . "$HOME/.p10k.zsh"
      eval $(/opt/homebrew/bin/brew shellenv)
      . "$HOME/dotfiles/.zshrc"
    '';
  };
}
