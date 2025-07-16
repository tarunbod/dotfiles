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
    pkgs.btop
    pkgs.carapace
    pkgs.delta
    pkgs.fortune
    pkgs.ffmpeg
    pkgs.go
    pkgs.gh
    pkgs.git-lfs
    pkgs.jq
    pkgs.kubectl
    pkgs.neofetch
    pkgs.neovim

    pkgs.nushell
    pkgs.nushellPlugins.polars
    pkgs.nushellPlugins.query
    pkgs.nushellPlugins.formats

    pkgs.ripgrep
    pkgs.starship
    pkgs.tmux
    pkgs.uv
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
        secrets.secrets_json = {
          file = ../secrets/secrets.age;
          path = "${homeDir}/.secrets.json";
        };
      };
    };
  };
}
