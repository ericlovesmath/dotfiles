{ config, ... }: {
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
}
