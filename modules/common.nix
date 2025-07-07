{ pkgs, config, system, agenix, ... }:

let
 isDarwin = pkgs.stdenv.hostPlatform.isDarwin;
 homeDir = if isDarwin then "/Users/tarunbod" else "/home/tarunbod";
in
{
  nixpkgs.config.allowUnfree = true;

  nix.settings.experimental-features = [ "nix-command" "flakes" ];

  environment.systemPackages = [
    pkgs.age
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
    (if isDarwin then pkgs.ghostty-bin else pkgs.ghostty)
    pkgs.jq
    pkgs.kubectl
    # pkgs.libgcc
    pkgs.neofetch
    pkgs.neovim

    pkgs.nushell
    pkgs.nushellPlugins.polars
    pkgs.nushellPlugins.query
    pkgs.nushellPlugins.formats
    pkgs.nushellPlugins.formats

    pkgs.ripgrep
    pkgs.spotify
    pkgs.starship
    pkgs.tmux
    pkgs.wget
    pkgs.yt-dlp

    agenix.packages.${system}.default
  ];

  age.identityPaths = ["${homeDir}/.ssh/id_ed25519"];

  users.users.tarunbod.home = homeDir;
  home-manager = {
    useGlobalPkgs = true;
    useUserPackages = true;

    backupFileExtension = "backup";

    sharedModules = [
      agenix.homeManagerModules.default
    ];

    users.tarunbod = {
      home = {
        username = "tarunbod";
        homeDirectory = homeDir;
        stateVersion = "25.05";
      };

      age = {
        secrets.github_token = {
          file = ../secrets/secrets.age;
          path = "${homeDir}/.secrets.json";
        };
      };
    };
  };
}
