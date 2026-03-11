{
  description = "NixOS MicroVM";

  # TODO: Fix rapid flickering while typing
  # TODO: remove path duplication
  # TODO: Put this somewhere online?
  # TODO: Make tmp folder actually new so I can have multiple instances

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

      shareConfigs = [
        {
          tag = "project-dir";
          hostPath = "$PROJECT_PATH";
          mountPoint = "/app";
        }
        {
          tag = "opencode-config";
          hostPath = "$HOME/.config/opencode";
          mountPoint = "/home/dev/.config/opencode";
        }
        {
          tag = "opencode-share";
          hostPath = "$HOME/.local/share/opencode";
          mountPoint = "/home/dev/.local/share/opencode";
        }
        {
          tag = "claudecode-config";
          hostPath = "$HOME/.claude";
          mountPoint = "/home/dev/.claude";
        }
      ];

      # Helper to get socket path from tag
      mkSock = tag: "${tmp}/${tag}.sock";
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

            # Cleanup function to kill virtiofsd processes and remove sockets
            cleanup() {
              echo "Shutting down..."
              jobs -p | xargs -r kill 2>/dev/null || true
              rm -f ${tmp}/*.sock ${tmp}/control.socket
            }
            trap cleanup EXIT

            echo "Starting virtiofsd daemons..."

            # Start standard shares from shareConfigs
            ${pkgs.lib.concatMapStringsSep "\n" (s: ''
              # Ensure host directory exists before sharing
              mkdir -p "${s.hostPath}" 2>/dev/null || true
              ${pkgs.virtiofsd}/bin/virtiofsd --shared-dir "${s.hostPath}" --socket "${mkSock s.tag}" --sandbox none --cache auto &
            '') shareConfigs}

            # Start Nix store share
            ${pkgs.virtiofsd}/bin/virtiofsd --shared-dir /nix/store --socket "${mkSock "nix-store"}" --sandbox none --cache auto &

            ${vm-runner}/bin/microvm-run
          '';
      };

      nixosConfigurations = {
        microjail = nixpkgs.lib.nixosSystem {
          inherit system;
          modules = [
            microvm.nixosModules.microvm
            (
              { pkgs, ... }:
              {
                system.stateVersion = "26.05";
                networking.hostName = "microvm";
                networking.useNetworkd = true;
                systemd.network.enable = true;
                systemd.network.networks."10-eth0" = {
                  matchConfig.Name = "eth0";
                  networkConfig.DHCP = "yes";
                };

                users.users.dev = {
                  isNormalUser = true;
                  extraGroups = [ "wheel" ];
                  password = "";
                };

                services.getty.autologinUser = "dev";

                users.users.root.password = "";
                security.sudo = {
                  enable = true;
                  wheelNeedsPassword = false;
                };

                environment.interactiveShellInit = ''
                  cd /app
                '';

                nixpkgs.config.allowUnfree = true;

                environment.systemPackages = with pkgs; [
                  neovim
                  python3
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
                  opencode
                  claude-code
                ];

                environment.sessionVariables = {
                  "TERM" = "xterm-256color";
                  "COLORTERM" = "truecolor";
                  "CLAUDE_CODE_DEBUGGING_SKIP_PERMISSIONS" = "true";
                  "OPENCODE_CONFIG_CONTENT" = ''
                    {
                      \"permission\": {
                        \"shell\": \"allow\",
                        \"edit\": \"allow\",
                        \"write\": \"allow\",
                        \"read\": \"allow\",
                        \"network\": \"allow\"
                      }
                    }
                  '';
                };

                nix.settings.experimental-features = [
                  "nix-command"
                  "flakes"
                ];

                # programs.git = {
                #   enable = true;
                #   config = {
                #     safe.directory = "/app";
                #   };
                # };

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
                      proto = "virtiofs";
                      tag = "ro-store";
                      source = "/nix/store";
                      mountPoint = "/nix/.ro-store";
                      socket = mkSock "nix-store";
                    }
                  ]
                  ++ (map (s: {
                    proto = "virtiofs";
                    tag = s.tag;
                    source = "/var/empty";
                    mountPoint = s.mountPoint;
                    socket = mkSock s.tag;
                  }) shareConfigs);
                };
              }
            )
          ];
        };
      };
    };
}
