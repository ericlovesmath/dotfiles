{
  description = "Eric's MacOS nix-darwin Flake";

  inputs = {
    nixpkgs.url = "github:NixOS/nixpkgs/nixpkgs-unstable";

    nix-darwin.url = "github:LnL7/nix-darwin";
    nix-darwin.inputs.nixpkgs.follows = "nixpkgs";

    home-manager.url = "github:nix-community/home-manager";
    home-manager.inputs.nixpkgs.follows = "nixpkgs";
  };

  outputs = { self, nix-darwin, home-manager, nixpkgs }:
  let
    user = "ericlee";
    darwinConfiguration = { pkgs, config, ... }: {

      environment.variables.HOMEBREW_NO_ANALYTICS = "1";
      homebrew = import ./nix/brew.nix { inherit config; };

      users.users.${user}.home = "/Users/${user}";
      home-manager.backupFileExtension = "backup";

      # Managed in home-manager
      programs.zsh = {
        enable = true;
        enableCompletion = false;
      };

      services.yabai.enable = true;
      services.skhd.enable = true;
      services.sketchybar.enable = true;
      services.jankyborders.enable = true;

      # Auto upgrade nix package and the daemon service.
      services.nix-daemon.enable = true;

      # Necessary for using flakes on this system.
      nix.settings.experimental-features = "nix-command flakes";

      # Set Git commit hash for darwin-version.
      system.configurationRevision = self.rev or self.dirtyRev or null;

      # Used for backwards compatibility, please read the changelog before changing.
      system.stateVersion = 5;

      # The platform the configuration will be used on.
      nixpkgs.hostPlatform = "aarch64-darwin";
    };
  in
  {
    # Command: nix run nix-darwin -- switch --flake ~/dotfiles\#macos
    darwinConfigurations."macos" = nix-darwin.lib.darwinSystem {
      modules = [
        darwinConfiguration

        home-manager.darwinModules.home-manager {
          home-manager.useGlobalPkgs = true;
          home-manager.useUserPackages = true;
          home-manager.users.${user} = import ./nix/home-darwin.nix;
        }
      ];
    };

    # nixosConfigurations."asahi" = nixpkgs.lib.nixosSystem {
    #   modules = [
    #     home-manager.linuxModules.home-manager {
    #       home-manager.useGlobalPkgs = true;
    #       home-manager.useUserPackages = true;
    #       home-manager.users.${user} = import ./nix/home-shared.nix;
    #     }
    #   ];
    # };

    # Expose the package set, including overlays, for convenience.
    darwinPackages = self.darwinConfigurations."macos".pkgs;
    linuxPackages = self.nixosConfigurations."fedora".pkgs;
  };
}
