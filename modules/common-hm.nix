{
  config,
  pkgs,
  lib,
  inputs,
  ...
}:
{
  nixpkgs.config.allowUnfree = true;

  nix = {
    package = pkgs.nix;
    settings.experimental-features = [
      "nix-command"
      "flakes"
    ];
  };

  home.packages = (import ./cli-packages.nix { inherit pkgs inputs; }) ++ [
    pkgs.nushell
  ];

  home.activation.shell-autoload = lib.hm.dag.entryAfter [ "writeBoundary" ] ''
    run env "PATH=${config.home.path}/bin:$PATH" ~/dotfiles/post-activation.nu;
  '';

  programs.home-manager.enable = true;

  programs.rex.enable = true;
  programs.rex.sshGuard = false;
  services.rex.enable = true;
}
