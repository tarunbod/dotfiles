{ ... }:

{
  system.primaryUser = "tarunbod";

  homebrew.enable = true;
  homebrew.brews = [
    "opencode"
  ];

  homebrew.casks = [
    "bitwarden"
    "raycast"
    "rectangle"
    "ghostty"
  ];

  system.defaults.controlcenter.BatteryShowPercentage = true;

  system.defaults.dock.autohide = true;
  system.defaults.dock.autohide-delay = 0.1;

  security.pam.services.sudo_local.enable = true;
  security.pam.services.sudo_local.touchIdAuth = true;
  security.pam.services.sudo_local.watchIdAuth = true;
  security.pam.services.sudo_local.reattach = true;
}

