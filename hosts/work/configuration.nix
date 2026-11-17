{
  pkgs,
  username,
  lib,
  ...
}:

{
  system.stateVersion = 6;
  system.primaryUser = lib.mkForce "tarun.boddupalli";

  nixpkgs.hostPlatform = "aarch64-darwin";

  environment.systemPackages = [
    pkgs.kind
    pkgs.k9s
  ];

  home-manager.users."${username}".home.file.gitconfig = lib.mkForce {
    source = ./.gitconfig;
    target = ".gitconfig";
  };
}
