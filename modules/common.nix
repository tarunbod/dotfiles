{
  pkgs,
  username,
  inputs,
  ...
}:

let
  isDarwin = pkgs.stdenv.hostPlatform.isDarwin;
  homeDir = if isDarwin then "/Users/${username}" else "/home/${username}";
in
{
  nixpkgs.config.allowUnfree = true;

  nix.settings.experimental-features = [
    "nix-command"
    "flakes"
  ];

  nix.settings.trusted-users = [
    "root"
    "${username}"
  ];

  environment.systemPackages = [
    pkgs.age
    pkgs.bat
    pkgs.btop
    pkgs.bun
    pkgs.cachix
    pkgs.carapace
    pkgs.difftastic
    pkgs.fastfetch
    pkgs.fortune
    pkgs.ffmpeg
    pkgs.go
    pkgs.gh
    pkgs.git-lfs
    pkgs.jq
    pkgs.jujutsu
    pkgs.kubectl
    pkgs.neovim
    pkgs.nodejs_24
    pkgs.ripgrep
    pkgs.starship
    pkgs.tmux
    pkgs.wget

    inputs.agenix.packages.${pkgs.stdenv.hostPlatform.system}.default
  ];

  users.users."${username}".home = homeDir;
  home-manager = {
    useGlobalPkgs = true;
    useUserPackages = true;

    backupFileExtension = "backup";

    sharedModules = [
      inputs.agenix.homeManagerModules.default
    ];

    users."${username}" =
      { lib, ... }:
      (import ./home.nix) { inherit pkgs username homeDir };
  };
}
