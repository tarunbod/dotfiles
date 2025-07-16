{ pkgs, config, system, agenix, ... }:

{
  environment.systemPackages = [
    pkgs.gcc
    pkgs.opencode
  ];

  programs.nix-ld.enable = true;
}
