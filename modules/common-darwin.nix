{ pkgs, ... }:

{
  system.primaryUser = "tarunbod";

  environment.systemPackages = [
    pkgs.bitwarden-desktop
    pkgs.raycast
    pkgs.rectangle

    pkgs.ghostty-bin
  ];

  homebrew.enable = true;
  homebrew.brews = [
    "opencode"
  ];

  system.defaults.controlcenter.BatteryShowPercentage = true;

  system.defaults.dock.autohide = true;
  system.defaults.dock.autohide-delay = 0.1;

  security.pam.services.sudo_local.enable = true;
  security.pam.services.sudo_local.touchIdAuth = true;
  security.pam.services.sudo_local.watchIdAuth = true;
  security.pam.services.sudo_local.reattach = true;
}

