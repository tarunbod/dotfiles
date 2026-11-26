{ pkgs, inputs }:

[
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
  pkgs.ripgrep
  pkgs.starship
  pkgs.tmux
  pkgs.wget
  pkgs.zoxide

  inputs.agenix.packages.${pkgs.stdenv.hostPlatform.system}.default
]
