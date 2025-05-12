{ config, pkgs, ... }:
{
  programs.home-manager.enable = true;
  home.username = "ericlee";
  home.enableNixpkgsReleaseCheck = false;
  home.stateVersion = "24.11";

  home.packages = with pkgs; [
    neovim tmux
    ripgrep lazygit jq
    imagemagick htop fzf fd ffmpeg
    tree wget nmap croc curl rlwrap fastfetch
    spicetify-cli coq deno pandoc
    nasm pandoc yt-dlp glow hugo docker gh
    julia-bin slides maven openjdk opam gnupatch
    micromamba texliveFull
    nodejs coreutils
    ghc haskell-language-server
    zsh zsh-powerlevel10k
    openjdk cargo
    meslo-lgs-nf font-awesome

    (python3.withPackages (pkgs: with pkgs; [
      pandas scipy numpy jupyterlab matplotlib
    ]))
  ];

  home.file = {
    "bin".source = ../scripts;
    ".tmux.conf".source = ../.tmux.conf;
    ".config/nvim".source = ../nvim;
    ".config/alacritty/alacritty.toml".source = ../alacritty.toml;
    ".latexmkrc".source = ../.latexmkrc;
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
      caltech   = "$HOME/Desktop/Academics/Caltech/junior/spring-2025";
      tutor     = "$HOME/Desktop/Academics/Tutoring";
      surf      = "$HOME/Desktop/Academics/Caltech/sophmore/SURF";
      finance   = "$HOME/Desktop/Important/finance";
      portfolio = "$HOME/Desktop/Programming/portfolio-eric-lee";
      usaco     = "$HOME/Desktop/Programming/competitive-programming";
    };
    plugins = [{
      name = "zsh-powerlevel10k";
      src = "${pkgs.zsh-powerlevel10k}/share/zsh-powerlevel10k/";
      file = "powerlevel10k.zsh-theme";
    }];
    initContent = ''
      . "$HOME/.p10k.zsh"
      . "$HOME/dotfiles/.zshrc"
    '';
  };
}
