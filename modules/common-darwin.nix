{ pkgs, ... }:

{
  environment.systemPackages = [
    pkgs.bitwarden-desktop
    pkgs.raycast
    pkgs.rectangle
  ];
}

