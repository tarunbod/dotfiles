{ config, pkgs, ... }:

{
  system.stateVersion = 6;

  nixpkgs.hostPlatform = "aarch64-darwin";

  environment.systemPackages = [
    pkgs.kind
    pkgs.k9s
    pkgs.google-chrome
  ];

  homebrew.casks = [
    "orbstack"
  ];
}

