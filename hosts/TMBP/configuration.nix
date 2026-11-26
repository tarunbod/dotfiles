{ pkgs, ... }:

{
  system.stateVersion = 6;

  nixpkgs.hostPlatform = "aarch64-darwin";

  homebrew.casks = [
    "audacity"
    "azure-cli"
    "balenaetcher"
    "blender"
    "codex"
    "discord"
    "localsend"
    "mitmproxy"
    "signal"
    "slack"
    "spotify"
    "t3-code"
    "terminal-browser"
    "utm"
    "wireshark-app"
  ];

  homebrew.brews = [
    "awscli"
    "bazel"
    "caddy"
    "cmake"
    "duckdb"
    "eigen"
    "exiftool"
    "fx"
    "fzf"
    "helm"
    "hf"
    "imagemagick"
    "ipatool"
    "john"
    "k9s"
    "netcat"
    "nmap"
    "ntfy"
    "openjdk"
    "openvpn"
    "picotool"
    "postgresql"
    "pwncat"
    "radare2"
    "railway"
    "rbenv"
    "redis"
    "shellcheck"
    "socat"
    "sqlmap"
    "sshpass"
    "tesseract"
    "usbutils"
    "watch"
    "websocat"
    "xq"
    "yq"
    "yt-dlp"
    "zig"
  ];

  environment.systemPackages = [
    pkgs.sdrpp
  ];

  system.defaults.dock.persistent-apps = [
    { app = "/Applications/Google Chrome.app"; }
    { app = "/System/Applications/Calendar.app"; }
    { spacer = {}; }
    { app = "/System/Applications/Messages.app"; }
    { app = "/Applications/Discord.app"; }
    { app = "/Applications/Signal.app"; }
    { app = "/Applications/Obsidian.app"; }
    { app = "/Applications/Spotify.app"; }
    { spacer = {}; }
    { app = "/Applications/Rex.app"; }
    { app = "/Applications/T3 Code (Beta).app"; }
    { app = "/System/Applications/System Settings.app"; }
  ];

}
