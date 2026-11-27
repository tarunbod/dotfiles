{ pkgs, ... }:

{
  imports = [
    ./hardware-configuration.nix
  ];

  boot.loader.grub.enable = false;
  boot.loader.generic-extlinux-compatible.enable = true;

  networking.hostName = "chimp";

  users.defaultUserShell = pkgs.nushell;

  system.stateVersion = "25.11";

  services.openssh.settings = {
    PasswordAuthentication = false;
    KbdInteractiveAuthentication = false;
  };

  environment.systemPackages = [
    pkgs.motion

    pkgs.nushell
    pkgs.nushellPlugins.polars
    pkgs.nushellPlugins.query
    pkgs.nushellPlugins.formats
  ];

  services.caddy = {
    enable = true;
    configFile = pkgs.writeText "Caddyfile" ''
      ntfy.tarunbod.com {
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
      base-url = "https://ntfy.tarunbod.com";
      listen-http = ":2586";
      auth-default-access = "deny-all";
      behind-proxy = true;
      upstream-base-url = "https://ntfy.sh";
      log-level = "info";
      log-format = "json";
      log-file = "/var/log/ntfy-sh/ntfy.log";
    };
  };

  systemd.services.ntfy-sh.serviceConfig.LogsDirectory = "ntfy-sh";
}
