{ pkgs, nushell, opencode, ... }:
let
  nushellPkg = nushell.packages.${pkgs.stdenv.hostPlatform.system}.nushell.overrideAttrs (oldAttrs: {
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
    nushellPkg
    opencode.packages.${pkgs.stdenv.hostPlatform.system}.default
  ];

  programs.nix-ld.enable = true;
}
