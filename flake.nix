{
  description = "Eric's MacOS nix-darwin Flake";

  inputs = {
    nixpkgs.url = "github:NixOS/nixpkgs/nixpkgs-unstable";

    nix-darwin.url = "github:LnL7/nix-darwin";
    nix-darwin.inputs.nixpkgs.follows = "nixpkgs";

    home-manager.url = "github:nix-community/home-manager";
    home-manager.inputs.nixpkgs.follows = "nixpkgs";

    nix-homebrew.url = "github:zhaofengli-wip/nix-homebrew";

    homebrew-core.url = "github:homebrew/homebrew-core";
    homebrew-core.flake = false;

    homebrew-cask.url = "github:homebrew/homebrew-cask";
    homebrew-cask.flake = false;

    homebrew-bundle.url = "github:homebrew/homebrew-bundle";
    homebrew-bundle.flake = false;
  };

  outputs = { self, nix-darwin, nix-homebrew, homebrew-core, homebrew-cask, homebrew-bundle, home-manager, nixpkgs }:
  let
    configuration = { pkgs, config, ... }: {

      # List packages installed in system profile. To search by name, run:
      environment.systemPackages = with pkgs; [
        neovim tmux
        ripgrep lazygit jq
        skhd yabai sketchybar jankyborders
        imagemagick htop fzf fd ffmpeg
        tree wget nmap croc curl rlwrap fastfetch
        spicetify-cli coq deno pandoc
        nasm pandoc yt-dlp glow hugo docker gh
        julia-bin slides maven openjdk opam
        micromamba texliveFull
        nodejs python3 coreutils
        ghc haskell-language-server
      ];

      # TODO: POWERLEVEL10k

      environment.variables.HOMEBREW_NO_ANALYTICS = "1";

      homebrew = {
        enable = true;
        taps = builtins.attrNames config.nix-homebrew.taps;

        onActivation = {
          autoUpdate = true;
          cleanup = "zap";
          upgrade = true;
        };

        casks = [
          "alacritty" "iina" "anki" "obs" "skim" "transmission" "blender"
          "discord" "zoom" "spotify" "google-chrome" "vnc-viewer" "onyx"
          "qlmarkdown" "dyalog" "slack" "godot" "minecraft" "rar" "steam"
          "appcleaner" "lulu" "protonmail-bridge" "karabiner-elements"
          "omnidisksweeper" "visual-studio-code" "alfred" "zotero" "firefox"
          "protonvpn"
        ];

        masApps = {
          "Things3" = 904280696;
          "Goodnotes" = 1444383602;
        };
      };

      users.users.ericlee.home = "/Users/ericlee";
      home-manager.backupFileExtension = "backup";
      programs.zsh = {
        enable = true;
        enableCompletion = false;  # Managed in home-manager
      };

      services.yabai.enable = true;
      services.skhd.enable = true;
      services.sketchybar.enable = true;
      services.jankyborders.enable = true;

      # Auto upgrade nix package and the daemon service.
      services.nix-daemon.enable = true;
      # nix.package = pkgs.nix;

      # Necessary for using flakes on this system.
      nix.settings.experimental-features = "nix-command flakes";

      # Set Git commit hash for darwin-version.
      system.configurationRevision = self.rev or self.dirtyRev or null;

      # Used for backwards compatibility, please read the changelog before changing.
      # $ darwin-rebuild changelog
      system.stateVersion = 5;

      # The platform the configuration will be used on.
      nixpkgs.hostPlatform = "aarch64-darwin";
    };
  in
  {
    # Build darwin flake using:
    # $ darwin-rebuild build --flake .#macos
    darwinConfigurations."macos" = nix-darwin.lib.darwinSystem {
      modules = [
        configuration

        nix-homebrew.darwinModules.nix-homebrew {
          nix-homebrew = {
            enable = true;
            enableRosetta = true;
            user = "ericlee";

            taps = {
              "homebrew/homebrew-core" = homebrew-core;
              "homebrew/homebrew-cask" = homebrew-cask;
              "homebrew/homebrew-bundle" = homebrew-bundle;
            };

            mutableTaps = false;
          };
        }

        home-manager.darwinModules.home-manager {
          home-manager.useGlobalPkgs = true;
          home-manager.useUserPackages = true;
          home-manager.users.ericlee = import ./nix/home.nix;
        }
      ];
    };

    # Expose the package set, including overlays, for convenience.
    darwinPackages = self.darwinConfigurations."macos".pkgs;
  };
}
