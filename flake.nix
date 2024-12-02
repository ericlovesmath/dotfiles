{
  description = "Eric's nix-darwin Flake";

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
  in
  {
    # Command: nix run nix-darwin -- switch --flake ~/dotfiles\#macos
    darwinConfigurations."macos" = nix-darwin.lib.darwinSystem {
      specialArgs.user = user;
      modules = [
        ./nix/nix-darwin.nix

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
  };
}
