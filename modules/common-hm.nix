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

  home.packages = [
    pkgs.age
    pkgs.carapace
    pkgs.difftastic
    pkgs.fortune
    pkgs.go
    pkgs.git
    pkgs.jq
    pkgs.neovim
    pkgs.nushell
    pkgs.ripgrep
    pkgs.starship
    pkgs.tmux
    pkgs.wget

    inputs.agenix.packages.${pkgs.stdenv.hostPlatform.system}.default
  ];

  home.activation.shell-autoload = lib.hm.dag.entryAfter [ "writeBoundary" ] ''
    run env "PATH=${config.home.path}/bin:$PATH" ~/dotfiles/post-activation.nu;
  '';

  programs.home-manager.enable = true;

  programs.ssh.enable = true;

  programs.rex.enable = true;
  services.rex.enable = true;
}
