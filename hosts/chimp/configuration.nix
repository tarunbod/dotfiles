{ pkgs, inputs, ... }:

{
  imports = [
    ./hardware-configuration.nix
  ];

  boot.loader.grub.enable = false;
  boot.loader.generic-extlinux-compatible.enable = true;

  networking.hostName = "chimp";

  nixpkgs.config.allowUnfree = true;

  nix.settings.experimental-features = [ "nix-command" "flakes" ];

  users.defaultUserShell = pkgs.nushell;

  system.stateVersion = "25.11";

  environment.systemPackages = [
    pkgs.git

    pkgs.nushell
    pkgs.nushellPlugins.polars
    pkgs.nushellPlugins.query
    pkgs.nushellPlugins.formats

    pkgs.ripgrep
    pkgs.starship
    pkgs.tmux
    pkgs.wget

    inputs.agenix.packages.${pkgs.stdenv.hostPlatform.system}.default
  ];

  services.caddy = {
    enable = true;
    configFile = pkgs.writeText "Caddyfile" ''
      ntfy.burritogaming.com {
          reverse_proxy 127.0.0.1:2586

          # Redirect HTTP to HTTPS, but only for GET topic addresses, since we want
          # it to work with curl without the annoying https:// prefix
          @httpget {
              protocol http
              method GET
              path_regexp ^/([-_a-z0-9]{0,64}$|docs/|static/)
          }
          redir @httpget https://{host}{uri}
      }
    '';
  };

  services.ntfy-sh = {
    enable = true;

    settings = {
      base-url = "https://ntfy.burritogaming.com";
      listen-http = ":2586";
      auth-default-access = "deny-all";
      behind-proxy = true;
      upstream-base-url = "https://ntfy.sh";
    };
  };
}
