{ pkgs, ...}:

{
  environment.systemPackages = [
    pkgs.astro-language-server
    pkgs.gopls
    pkgs.nil
    pkgs.ruff
    (pkgs.typescript-language-server.overrideAttrs (oldAttrs: {
      # Work around the pnpm dependency hash mismatch in the pinned nixpkgs.
      pnpmDeps = oldAttrs.pnpmDeps.overrideAttrs (deps: {
        outputHash =
          if deps.outputHash == "sha256-MUSxDMlbG21KSesGdEvqa2kEpuVfLlXRUX1qV/FGsSo=" then
            "sha256-xR/EF60lVBsITKgH7wCM2wHM46PFQevD51KfCENSUH4="
          else
            deps.outputHash;
      });
    }))

    pkgs.uv
    pkgs.rustup
  ];
}
