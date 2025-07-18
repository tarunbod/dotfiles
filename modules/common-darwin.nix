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
}

