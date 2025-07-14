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
    pkgs.fortune
    pkgs.ffmpeg
    pkgs.go
    pkgs.google-chrome
    pkgs.goose-cli
    pkgs.gcc
    pkgs.gh
    pkgs.git-lfs
    pkgs.jq
    pkgs.kubectl
    # pkgs.libgcc
    pkgs.neofetch
    pkgs.neovim

    pkgs.nushell
    pkgs.nushellPlugins.polars
    pkgs.nushellPlugins.query
    pkgs.nushellPlugins.formats

    pkgs.ripgrep
    pkgs.spotify
    pkgs.starship
    pkgs.tmux
    pkgs.wget
    pkgs.yt-dlp

    agenix.packages.${system}.default
  ];

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

        file = {
          bashrc = {
            source = ../.bashrc;
            target = ".bashrc";
          };
        };
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
