{
  pkgs,
  lib,
  ...
}:

{
  system.stateVersion = 6;
  system.primaryUser = lib.mkForce "tarun.boddupalli";

  nixpkgs.hostPlatform = "aarch64-darwin";

  nix.settings = {
    extra-substituters = [
      "https://nix-cache.us1.ddbuild.io"
    ];
    extra-trusted-public-keys = [
      "nix-cache-1:lewDOuKvEqMCvbAiRtFiB2JnjFbkoUxxBEWh8C3voOY="
    ];
    connect-timeout = 1;
  };

  environment.systemPackages = [
    pkgs.kind
    pkgs.k9s
  ];
}
