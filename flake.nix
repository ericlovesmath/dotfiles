{
  description = "ericlovesmath's nix-darwin + home-manager Flake";

  inputs = {
    nixpkgs.url = "github:NixOS/nixpkgs/nixpkgs-unstable";

    nix-darwin.url = "github:LnL7/nix-darwin";
    nix-darwin.inputs.nixpkgs.follows = "nixpkgs";

    home-manager.url = "github:nix-community/home-manager";
    home-manager.inputs.nixpkgs.follows = "nixpkgs";

    nixpkgs-firefox-darwin.url = "github:bandithedoge/nixpkgs-firefox-darwin";
    nixpkgs-firefox-darwin.inputs.nixpkgs.follows = "nixpkgs";

    nixgl.url = "github:nix-community/nixGL";
    nixgl.inputs.nixpkgs.follows = "nixpkgs";

  };

  outputs = { self, nix-darwin, home-manager, nixpkgs, nixpkgs-firefox-darwin, nixgl }:
  let
    user = "ericlee";
    # pkgs = nixpkgs.legacyPackages.x86_64-linux;
    system = "x86_64-linux";
    pkgs = import nixpkgs {
      inherit system;
      config.allowUnfree = true;
      overlays = [ nixgl.overlay ];
    };
  in
  {
    # Made for M1 Macbook Pro
    # Command: nix run nix-darwin -- switch --flake "$HOME/dotfiles#macos"
    darwinConfigurations."macos" = nix-darwin.lib.darwinSystem {
      specialArgs.user = user;
      modules = [
        ./nix/nix-darwin.nix

        home-manager.darwinModules.home-manager {
          nixpkgs.overlays = [ nixpkgs-firefox-darwin.overlay ];
          home-manager.useGlobalPkgs = true;
          home-manager.useUserPackages = true;
          home-manager.users.${user} = import ./nix/home-darwin.nix;
        }
      ];
    };

    # Made for Framework 13 with AMD CPU
    # Command: nix run home-manager -- switch --flake "$HOME/dotfiles#fedora"
    homeConfigurations."fedora" = home-manager.lib.homeManagerConfiguration {
      inherit pkgs;
      modules = [
        # For WebCord
        ({
          nixpkgs.config.permittedInsecurePackages = [
            "electron-36.9.5"
          ];
        })

        (import ./nix/home-fedora.nix { nixgl = nixgl; })
      ];
    };

    # Expose the package set, including overlays, for convenience.
    darwinPackages = self.darwinConfigurations."macos".pkgs;
  };
}
