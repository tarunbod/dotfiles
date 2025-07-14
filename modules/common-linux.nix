{ pkgs, config, system, agenix, ... }:

{
  environment.systemPackages = [
    pkgs.opencode
  ];
}
