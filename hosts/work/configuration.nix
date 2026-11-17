{ pkgs, lib, ... }:

{
  system.stateVersion = 6;
  system.primaryUser = lib.mkForce "tarun.boddupalli";

  nixpkgs.hostPlatform = "aarch64-darwin";

  environment.systemPackages = [
    pkgs.kind
    pkgs.k9s
  ];
}

