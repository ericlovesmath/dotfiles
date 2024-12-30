{
  description = "Eric's nix-darwin Flake";

  inputs = {
    nixpkgs.url = "github:NixOS/nixpkgs/nixpkgs-unstable";

    nix-darwin.url = "github:LnL7/nix-darwin";
    nix-darwin.inputs.nixpkgs.follows = "nixpkgs";

    home-manager.url = "github:nix-community/home-manager";
    home-manager.inputs.nixpkgs.follows = "nixpkgs";

    nixpkgs-firefox-darwin.url = "github:bandithedoge/nixpkgs-firefox-darwin";
    nixpkgs-firefox-darwin.inputs.nixpkgs.follows = "nixpkgs";
  };

  outputs = { self, nix-darwin, home-manager, nixpkgs, nixpkgs-firefox-darwin }:
  let
    user = "ericlee";
    pkgs = nixpkgs.legacyPackages.x86_64-linux;
  in
  {
    # Made for M1 Macbook Pro
    # Command: nix run nix-darwin -- switch --flake "~/dotfiles#macos"
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
    # Command: nix run home-manager -- switch --flake "~/dotfiles#fedora"
    homeConfigurations."fedora" = home-manager.lib.homeManagerConfiguration {
      inherit pkgs;
      modules = [ ./nix/home-fedora.nix ];
    };

    # Expose the package set, including overlays, for convenience.
    darwinPackages = self.darwinConfigurations."macos".pkgs;
  };
}
