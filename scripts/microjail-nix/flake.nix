{
  description = "NixOS MicroVM";

  # TODO: Remove 9p dep
  # TODO: Factor out to generic opencode I can import
  # TODO: Remove /home/ericlee explicit
  # TODO: Fix rapid flickering while typing
  # TODO: remove path duplication
  # TODO: Put this somewhere online?

  inputs = {
    nixpkgs.url = "github:nixos/nixpkgs/nixos-unstable";

    microvm = {
      url = "github:microvm-nix/microvm.nix";
      inputs.nixpkgs.follows = "nixpkgs";
    };
  };

  outputs =
    {
      self,
      nixpkgs,
      microvm,
    }:
    let
      system = "x86_64-linux";
      tmp = "/tmp/microvm";
    in
    {
      packages.${system} = {
        default = self.packages.${system}.microjail;
        microjail =
          let
            pkgs = nixpkgs.legacyPackages.${system};
            vm-runner = self.nixosConfigurations.microjail.config.microvm.declaredRunner;
          in
          pkgs.writeShellScriptBin "run-microjail" ''
            PROJECT_PATH=$(readlink -f "''${1}")

            if [ ! -d "$PROJECT_PATH" ]; then
              echo "Error: $PROJECT_PATH is not a directory."
              exit 1
            fi

            mkdir -p ${tmp}

            # Define sockets
            PROJ_SOCK="${tmp}/virtiofs.sock"
            CONF_SOCK="${tmp}/opencode-config.sock"
            DATA_SOCK="${tmp}/opencode-share.sock"

            # Cleanup old sockets
            rm -f "$PROJ_SOCK" "$CONF_SOCK" "$DATA_SOCK"

            ${pkgs.virtiofsd}/bin/virtiofsd --shared-dir "$PROJECT_PATH" --socket-path "$PROJ_SOCK" --sandbox none &
            P1=$!
            ${pkgs.virtiofsd}/bin/virtiofsd --shared-dir /home/ericlee/.config/opencode --socket-path "$CONF_SOCK" --sandbox none &
            P2=$!
            ${pkgs.virtiofsd}/bin/virtiofsd --shared-dir /home/ericlee/.local/share/opencode --socket-path "$DATA_SOCK" --sandbox none &
            P3=$!

            cleanup() {
              kill $P1 $P2 $P3 2>/dev/null || true
              rm -f "$PROJ_SOCK" "$CONF_SOCK" "$DATA_SOCK" "${tmp}/control.socket"
            }
            trap cleanup EXIT

            ${vm-runner}/bin/microvm-run
          '';
      };

      nixosConfigurations = {
        microjail = nixpkgs.lib.nixosSystem {
          inherit system;
          modules = [
            microvm.nixosModules.microvm
            {
              networking.hostName = "microvm";
              networking.useNetworkd = true;
              systemd.network.enable = true;
              systemd.network.networks."10-eth0" = {
                matchConfig.Name = "eth0";
                networkConfig.DHCP = "yes";
              };

              users.users.root.password = "";

              system.stateVersion = "26.05";

              environment.interactiveShellInit = ''
                cd /app
              '';

              environment.systemPackages =
                with nixpkgs.legacyPackages.${system};
                pkgs.lib.flatten [
                  neovim
                  python3
                  opencode
                  bashInteractive
                  curl
                  wget
                  jq
                  which
                  ripgrep
                  gnugrep
                  gawkInteractive
                  ps
                  findutils
                  diffutils
                  binutils
                  gcc
                  gnumake
                ];

              environment.sessionVariables = {
                "TERM" = "xterm-256color";
                "COLORTERM" = "truecolor";
              };

              services.getty.autologinUser = "root";

              nix.settings.experimental-features = [
                "nix-command"
                "flakes"
              ];

              programs.git = {
                enable = true;
                config = {
                  safe.directory = "/app";
                };
              };

              programs.direnv = {
                enable = true;
                nix-direnv.enable = true;
              };

              environment.etc."direnv/direnv.toml".text = ''
                [whitelist]
                prefix = [ "/app" ]
              '';

              microvm = {
                hypervisor = "qemu";
                mem = 4096;
                vcpu = 4;
                socket = "${tmp}/control.socket";
                interfaces = [
                  {
                    type = "user";
                    id = "vm-nic";
                    mac = "02:00:00:00:00:01";
                  }
                ];

                writableStoreOverlay = "/nix/.rw-store";

                volumes = [
                  {
                    mountPoint = "/var";
                    image = "${tmp}/var.img";
                    size = 256;
                  }
                ];
                shares = [
                  {
                    # use proto = "virtiofs" for MicroVMs that are started by systemd
                    proto = "9p";
                    tag = "ro-store";
                    # a host's /nix/store will be picked up so that no
                    # squashfs/erofs will be built for it.
                    source = "/nix/store";
                    mountPoint = "/nix/.ro-store";
                  }
                  {
                    proto = "virtiofs";
                    tag = "opencode-config";
                    source = "/home/ericlee/.config/opencode";
                    mountPoint = "/root/.config/opencode";
                    socket = "${tmp}/opencode-config.sock";
                  }
                  {
                    proto = "virtiofs";
                    tag = "opencode-cache";
                    source = "/home/ericlee/.local/share/opencode";
                    mountPoint = "/root/.local/share/opencode";
                    socket = "${tmp}/opencode-share.sock";
                  }
                  {
                    # Share the project directory
                    proto = "virtiofs";
                    tag = "project-dir";
                    source = "/var/empty";
                    mountPoint = "/app";
                    socket = "${tmp}/virtiofs.sock";
                  }
                ];
              };
            }
          ];
        };
      };
    };
}
