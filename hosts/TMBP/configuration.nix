{ pkgs, ... }:

{
  system.stateVersion = 6;

  nixpkgs.hostPlatform = "aarch64-darwin";

  homebrew.casks = [
    "google-chrome"
    "discord"
    "signal"
    "spotify"
  ];

  environment.systemPackages = [
    pkgs.ipatool
    pkgs.yt-dlp
  ];

  system.defaults.dock.persistent-apps = [
    { app = "/Applications/Google Chrome.app"; }
    { app = "/System/Applications/Calendar.app"; }
    { spacer = {}; }
    { app = "/System/Applications/Messages.app"; }
    { app = "/Applications/Discord.app"; }
    { app = "/Applications/Signal.app"; }
    { app = "/Applications/Spotify.app"; }
    { spacer = {}; }
    { app = "/Applications/Ghostty.app"; }
    { app = "/System/Applications/System Settings.app"; }
  ];

}
