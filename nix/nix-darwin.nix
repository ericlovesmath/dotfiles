{ pkgs, config, user, ... }:
{
  users.users.${user}.home = "/Users/${user}";

  environment.variables.HOMEBREW_NO_ANALYTICS = "1";
  homebrew = import ./brew.nix { inherit config; };

  home-manager.backupFileExtension = "backup";
  nix.settings.experimental-features = "nix-command flakes";
  system.stateVersion = 5;
  nixpkgs.hostPlatform = "aarch64-darwin";

  # Managed in home-manager
  programs.zsh = {
    enable = true;
    enableCompletion = false;
  };

  # Services
  services = {
    yabai = {
      enable = true;
      enableScriptingAddition = true;
    };
    skhd.enable = true;
    sketchybar.enable = true;
    jankyborders.enable = true;
    nix-daemon.enable = true;
  };

  # Custom Settings, to instantly apply without reboot:
  # /System/Library/PrivateFrameworks/SystemAdministration.framework/Resources/activateSettings -u

  system.defaults = {
    dock = {
      autohide = true;
      show-recents = false;
      static-only = true;
    };
    trackpad = {
      Clicking = true;
      TrackpadRightClick = true;
    };
    NSGlobalDomain = {
      InitialKeyRepeat = 15;
      KeyRepeat = 2;
      _HIHideMenuBar = true;
    };
    finder.AppleShowAllExtensions = true;
    WindowManager.EnableStandardClickToShowDesktop = true;
  };

  security.pam.enableSudoTouchIdAuth = true;
}
