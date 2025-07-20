{ config, pkgs, ... }:

{
  system.stateVersion = 6;

  nixpkgs.hostPlatform = "aarch64-darwin";

  environment.systemPackages = [
    pkgs.google-chrome
    pkgs.discord
    pkgs.ipatool
    pkgs.spotify
    pkgs.uv
    pkgs.yt-dlp
  ];
}
