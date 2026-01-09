{ config, pkgs, ... }:

let
  # Allows neovim to write to folder as well, like lazy.lock
  mkSymlink = link : config.lib.file.mkOutOfStoreSymlink "${config.home.homeDirectory}/dotfiles/${link}";
in
{
  programs.home-manager.enable = true;
  home.username = "ericlee";
  home.enableNixpkgsReleaseCheck = false;
  home.stateVersion = "24.11";

  home.packages = with pkgs; [
    neovim tmux
    ripgrep lazygit jq
    imagemagick htop fzf fd ffmpeg zstd
    tree wget nmap croc curl rlwrap fastfetch
    spicetify-cli coq deno pandoc
    nasm pandoc yt-dlp glow hugo docker gh
    julia-bin slides maven openjdk opam gnupatch elan
    micromamba texliveFull nodejs coreutils
    zsh zsh-powerlevel10k xxd
    openjdk cargo ghc
    meslo-lgs-nf font-awesome hledger

    # LSPs
    pyright haskell-language-server clojure-lsp clang-tools
    rust-analyzer svelte-language-server typescript-language-server
    lua-language-server vscode-langservers-extracted
    bash-language-server shellcheck

    # Linters and Formatters
    clj-kondo eslint_d prettierd asmfmt shfmt stylua fourmolu
    tree-sitter

    (python3.withPackages (pkgs: with pkgs; [
      pandas scipy numpy jupyterlab matplotlib
      flake8 black isort
    ]))
  ];

  home.file = {
    ".tmux.conf".source = ../.tmux.conf;
    ".config/nvim".source = mkSymlink "nvim";
    ".config/alacritty/alacritty.toml".source = ../alacritty.toml;
    ".latexmkrc".source = ../.latexmkrc;
  };

  home.sessionVariables = {
    EDITOR = "nvim";
    MOZ_ENABLE_WAYLAND = "1";
  };

  programs.script-directory = {
    enable = true;
    settings = {
      SD_ROOT = "${config.home.homeDirectory}/dotfiles/scripts";
    };
  };

  programs.fzf = {
    enable = true;
    enableZshIntegration = true;
    enableBashIntegration = true;
  };

  programs.starship = {
    enable = true;
    enableBashIntegration = true;
  };

  programs.opam.enable = true;

  programs.zsh = {
    enable = true;
    enableCompletion = false;
    dirHashes = {
      dotfiles  = "$HOME/dotfiles";
      jane      = "$HOME/Desktop/Important/Jane Street";
      caltech   = "$HOME/Desktop/Academics/Caltech/senior/winter-2026";
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

  programs.bash = {
    enable = true;
    shellAliases = {
      c = "clear";
      lt = "du -sh * | sort -hr";
      ls = "ls -N --group-directories-first --color=auto";
      py = "python";
      py3 = "python";
      ".." = "cd ./..";
      "..." = "cd ./../..";
      "...." = "cd ./../../..";
    };
  };
}
