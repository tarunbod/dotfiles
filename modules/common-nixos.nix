{ pkgs, inputs, ... }:
let
  nushellPkg = inputs.nushell.packages.${pkgs.stdenv.hostPlatform.system}.nushell.overrideAttrs (oldAttrs: {
    passthru = (oldAttrs.passthru or { }) // {
      shellPath = "/bin/nu";
    };
    doCheck = false;
    doInstallCheck = false;
  });
in
{
  environment.systemPackages = [
    pkgs.file
    pkgs.gcc
    pkgs.unzip
    pkgs.claude-code
    nushellPkg
    inputs.opencode.packages.${pkgs.stdenv.hostPlatform.system}.default
  ];

  programs.nix-ld.enable = true;
}
