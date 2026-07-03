{
  description = "NixOS MicroVM";

  # TODO: Put this somewhere online?
  # TODO: Make tmp folder actually new so I can have multiple instances
  #       (blocked: tmp is baked into sockets/volumes at build time)
  # TODO: cp tmux config

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
      lib = nixpkgs.lib;
      mkSock = tag: "${tmp}/${tag}.sock";

      shares = [
        {
          tag = "project";
          host = "$PROJECT_PATH";
          guest = "/app";
        }
        {
          tag = "opencode-config";
          host = "$HOME/.config/opencode";
          guest = "/home/dev/.config/opencode";
        }
        {
          tag = "opencode-state";
          host = "$HOME/.local/state/opencode";
          guest = "/home/dev/.local/state/opencode";
        }
        {
          tag = "opencode-data";
          host = "$HOME/.local/share/opencode";
          guest = "/home/dev/.local/share/opencode";
        }
        {
          tag = "claude";
          host = "$HOME/.claude";
          guest = "/home/dev/.claude";
        }
      ];
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

            # Make sure every shared host dir exists before we hand it to virtiofsd
            ${lib.concatMapStringsSep "\n            " (s: ''mkdir -p "${s.host}"'') shares}

            # On the host, Claude Code keeps .claude.json at ~/.claude.json
            if [ -f "$HOME/.claude.json" ] && \
               { [ ! -f "$HOME/.claude/.claude.json" ] || \
                 [ "$HOME/.claude.json" -nt "$HOME/.claude/.claude.json" ]; }; then
              cp -p "$HOME/.claude.json" "$HOME/.claude/.claude.json"
            fi

            cleanup() {
              echo "Shutting down..."
              if [ -f "$HOME/.claude/.claude.json" ]; then
                cp -p "$HOME/.claude/.claude.json" "$HOME/.claude.json"
              fi
              jobs -p | xargs -r kill 2>/dev/null || true
              rm -f ${tmp}/*.sock ${tmp}/control.socket
            }
            trap cleanup EXIT

            echo "Starting virtiofsd daemons..."
            # One daemon per share
            ${lib.concatMapStringsSep "\n            " (s: ''
              ${pkgs.virtiofsd}/bin/virtiofsd --shared-dir "${s.host}" --socket "${mkSock s.tag}" --sandbox none --cache auto &
            '') shares}
            # Nix store
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

                users.groups.dev = {
                  gid = 1000;
                };

                users.users.dev = {
                  isNormalUser = true;
                  uid = 1000;
                  group = "dev";
                  extraGroups = [ "wheel" ];
                  password = "";
                  home = "/home/dev";
                  createHome = true;
                };

                services.getty.autologinUser = "dev";

                users.users.root.password = "";
                security.sudo = {
                  enable = true;
                  wheelNeedsPassword = false;
                };

                environment.interactiveShellInit = ''
                  cd /app
                  alias shut='sudo shutdown now'
                  alias claude='claude --dangerously-skip-permissions'
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
                  tmux
                  opencode
                  claude-code
                ];
                environment.sessionVariables = {
                  "TERM" = "xterm-256color";
                  "COLORTERM" = "truecolor";
                  "ENABLE_LSP_TOOL" = "1";
                  "CLAUDE_CONFIG_DIR" = "/home/dev/.claude";
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
                  # source = /var/empty because the daemons are started externally
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
                    mountPoint = s.guest;
                    socket = mkSock s.tag;
                  }) shares);
                };
              }
            )
          ];
        };
      };
    };
}
