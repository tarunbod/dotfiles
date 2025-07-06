{ pkgs, ... }:

{
  nixpkgs.config.allowUnfree = true;

  nix.settings.experimental-features = [ "nix-command" "flakes" ];

  environment.systemPackages = [
    pkgs.bat
    pkgs.bitwarden-desktop
    pkgs.btop
    pkgs.carapace
    pkgs.delta
    pkgs.discord
    pkgs.fortune
    pkgs.ffmpeg
    pkgs.go
    pkgs.google-chrome
    pkgs.goose-cli
    pkgs.gcc
    pkgs.git-lfs
    (if pkgs.stdenv.hostPlatform.isDarwin then pkgs.ghostty-bin else pkgs.ghostty)
    pkgs.kubectl
    # pkgs.libgcc
    pkgs.neofetch
    pkgs.neovim
    pkgs.nushell
    pkgs.nushellPlugins.polars
    pkgs.ripgrep
    pkgs.spotify
    pkgs.starship
    pkgs.tmux
    pkgs.wget
    pkgs.yt-dlp
  ];
}
