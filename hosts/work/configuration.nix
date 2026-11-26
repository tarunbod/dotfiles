{
  pkgs,
  inputs,
  ...
}:
let
 ddpkgs = inputs.datadog.packages.${pkgs.stdenv.hostPlatform.system};
in
{
  system.stateVersion = 6;

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
    pkgs.d2

    ddpkgs.bzl
    ddpkgs.canary
    ddpkgs.datadog-ci
    ddpkgs.dd-auth
    ddpkgs.ddtool
    (ddpkgs.gopls.overrideAttrs { doCheck = false; })
    ddpkgs.workspaces
    ddpkgs.workspaces-tool-helper
  ];
}
