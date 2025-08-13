{ pkgs, ... }:

{
  system.stateVersion = 6;

  nixpkgs.hostPlatform = "aarch64-darwin";

  environment.systemPackages = [
    pkgs.google-chrome
    pkgs.discord
    pkgs.ipatool
    pkgs.signal-desktop-bin
    pkgs.spotify
    pkgs.yt-dlp
  ];

  system.defaults.dock.persistent-apps = [
    { app = "/Applications/Nix Apps/Google Chrome.app"; }
    { app = "/System/Applications/Calendar.app"; }
    { spacer = {}; }
    { app = "/System/Applications/Messages.app"; }
    { app = "/Applications/Nix Apps/Discord.app"; }
    { app = "/Applications/Nix Apps/Signal.app"; }
    { app = "/Applications/Nix Apps/Spotify.app"; }
    { spacer = {}; }
    { app = "/Applications/Nix Apps/Ghostty.app"; }
    { app = "/System/Applications/System Settings.app"; }
  ];

}
