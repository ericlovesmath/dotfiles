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
      autohide-delay = 0.0;
      autohide-time-modifier = 0.2;
      persistent-apps = [
        "/Users/${user}/Applications/Home Manager Trampolines/Firefox.app"
        "/System/Applications/Messages.app"
        "/System/Applications/Mail.app"
        "/Applications/Steam.app"
        "/Applications/Discord.app"
        "/Applications/Slack.app"
        "/Applications/Spotify.app"
        "/Applications/Things3.app"
      ];
      show-recents = false;
      static-only = false;
      mru-spaces = false;
    };
    trackpad = {
      Clicking = true;
      TrackpadRightClick = true; # TODO: Doesn't work?
    };
    NSGlobalDomain = {
      InitialKeyRepeat = 15;
      KeyRepeat = 2;
      _HIHideMenuBar = true;
    };
    finder = {
      AppleShowAllExtensions = true;
      AppleShowAllFiles = true;
    };
    WindowManager.EnableStandardClickToShowDesktop = false;
  };

  security.pam.enableSudoTouchIdAuth = true;
}
