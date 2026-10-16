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
    (opencode.packages.${pkgs.stdenv.hostPlatform.system}.default.overrideAttrs (oldAttrs: {
      # Upstream's source filter omits this CLI build dependency.
      postPatch = (oldAttrs.postPatch or "") + ''
        mkdir -p script
        cp ${opencode}/script/native-arch.ts script/native-arch.ts
      '';
    }))
  ];

  programs.nix-ld.enable = true;
}
