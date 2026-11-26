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

  programs.home-manager.enable = true;
  home.packages = [
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
    pkgs.git
    pkgs.git-lfs
    pkgs.jq
    pkgs.jujutsu
    pkgs.kubectl
    pkgs.neovim
    pkgs.nodejs_24
    pkgs.nushell
    pkgs.ripgrep
    pkgs.rustup
    pkgs.starship
    pkgs.tmux
    pkgs.wget

    inputs.agenix.packages.${pkgs.stdenv.hostPlatform.system}.default
  ];

  home.activation.shell-autoload = lib.hm.dag.entryAfter [ "writeBoundary" ] ''
    run env "PATH=${config.home.path}/bin:$PATH" ~/dotfiles/post-activation.nu;
  '';
}
