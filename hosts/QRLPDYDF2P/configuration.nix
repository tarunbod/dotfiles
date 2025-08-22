{ pkgs, ... }:

{
  system.stateVersion = 6;

  nixpkgs.hostPlatform = "aarch64-darwin";

  environment.systemPackages = [
    pkgs.kind
    pkgs.k9s
  ];

  homebrew.brews = [
    "duckdb"
  ];

  homebrew.casks = [
    "orbstack"
  ];
}

