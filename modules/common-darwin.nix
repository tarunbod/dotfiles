{ ... }:

{
  system.primaryUser = "tarunbod";

  homebrew.enable = true;
  homebrew.brews = [
    {
      name = "anomalyco/tap/opencode-v2";
      trusted = true;
    }
  ];

  homebrew.casks = [
    "google-chrome"
    "bitwarden"
    "raycast"
    "rectangle"
    "ghostty"
    "obsidian"
  ];

  # Dock
  system.defaults.dock = {
    autohide = true;
    autohide-delay = 0.1;
    tilesize = 43;
    minimize-to-application = true;
    show-process-indicators = true;
    # top-left hot corner: Mission Control
    wvous-tl-corner = 2;
    # bottom-right hot corner: Quick Note
    wvous-br-corner = 14;
  };

  system.defaults.controlcenter.BatteryShowPercentage = true;

  # Finder
  system.defaults.finder = {
    AppleShowAllFiles = true;
    AppleShowAllExtensions = true;
    # column view
    FXPreferredViewStyle = "clmv";
    FXEnableExtensionChangeWarning = false;
    ShowPathbar = true;
    ShowExternalHardDrivesOnDesktop = true;
  };

  # Global
  system.defaults.NSGlobalDomain = {
    AppleInterfaceStyle = "Dark";
    AppleICUForce24HourTime = true;
    AppleShowAllExtensions = true;
    NSDocumentSaveNewDocumentsToCloud = false;
    NSNavPanelExpandedStateForSaveMode = true;
    NSNavPanelExpandedStateForSaveMode2 = true;
  };

  # Menu bar clock
  system.defaults.menuExtraClock = {
    Show24Hour = true;
    ShowDate = 1;
    ShowDayOfWeek = true;
    ShowSeconds = true;
    IsAnalog = false;
  };

  # Trackpad
  system.defaults.trackpad = {
    # tap to click off
    Clicking = false;
    TrackpadRightClick = true;
    TrackpadThreeFingerDrag = false;
  };

  # Screenshots
  system.defaults.screencapture = {
    type = "png";
    target = "file";
  };

  # Security
  system.defaults.LaunchServices.LSQuarantine = false;
  system.defaults.screensaver = {
    askForPassword = true;
    askForPasswordDelay = 0;
  };

  security.pam.services.sudo_local.enable = true;
  security.pam.services.sudo_local.touchIdAuth = true;
  security.pam.services.sudo_local.watchIdAuth = true;
  security.pam.services.sudo_local.reattach = true;
}
