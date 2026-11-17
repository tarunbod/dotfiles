{ pkgs, nushell, ... }:
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
  ];

  programs.nix-ld.enable = true;
}
