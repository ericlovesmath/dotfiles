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
    tmux ripgrep lazygit jq
    imagemagick htop fzf fd ffmpeg zstd
    tree wget nmap croc curl rlwrap fastfetch
    spicetify-cli coq deno pandoc
    nasm pandoc yt-dlp glow hugo docker gh
    julia-bin slides maven openjdk opam gnupatch elan
    micromamba texliveFull nodejs coreutils
    zsh zsh-powerlevel10k xxd entr
    openjdk cargo ghc meslo-lgs-nf font-awesome hledger
    vscode

    # LSPs
    pyright haskell-language-server clojure-lsp clang-tools
    rust-analyzer svelte-language-server typescript-language-server
    lua-language-server vscode-langservers-extracted
    bash-language-server shellcheck tex-fmt nixd

    # Linters and Formatters
    clj-kondo eslint_d prettierd asmfmt shfmt stylua ormolu
    tree-sitter nixfmt

    (python3.withPackages (pkgs: with pkgs; [
      pandas scipy numpy jupyterlab matplotlib
      flake8 black isort
    ]))

    (pkgs.neovim.override {
       withPython3 = true;
       withRuby = false;
       extraPython3Packages = (ps: with ps; [ pynvim flake8 ]);
    })

    (llm.withPlugins { llm-gemini = true; llm-anthropic = true; })
  ];

  home.file = {
    ".tmux.conf".source = ../.tmux.conf;
    ".config/nvim".source = mkSymlink "nvim";
    ".config/alacritty/alacritty.toml".source = mkSymlink "alacritty.toml";
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
    dotDir = config.home.homeDirectory;
    enableCompletion = false;
    dirHashes = {
      dotfiles  = "$HOME/dotfiles";
      jane      = "$HOME/Desktop/Important/Jane Street";
      obsidian  = "$HOME/Desktop/Obsidian/Eric";
      tutor     = "$HOME/Desktop/Academics/Tutoring";
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

  programs.claude-code = {
    enable = true;
    enableMcpIntegration = false;
    context = ../llm/global.md;
    skills = {
      ocaml = ../llm/ocaml.md;
      simpl = ../llm/simpl.md;
    };
    settings = {
      model = "opus";
      disableBundledSkills = true;
      skipDangerousModePermissionPrompt = true;
      showClearContextOnPlanAccept = true;
      tui = "fullscreen";
      theme = "dark";
      statusLine = {
        command = ../llm/statusline.sh;
        type = "command";
      };
    };
  };
}
