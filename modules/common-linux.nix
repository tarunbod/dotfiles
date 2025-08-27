{ pkgs, ... }:

{
  environment.systemPackages = [
    pkgs.file
    pkgs.gcc
    pkgs.unzip
  ];

  programs.nix-ld.enable = true;
}
