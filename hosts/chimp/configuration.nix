{ config, pkgs, inputs, system, agenix, ... }:

let
  homeDir = "/home/tarunbod";
in
{
  imports = [
    ./hardware-configuration.nix
  ];

  # boot.loader.systemd-boot.enable = true;
  # boot.loader.efi.canTouchEfiVariables = true;

  boot.kernelPackages = pkgs.linuxPackages_latest;

  networking.hostName = "chimp";

  networking.networkmanager.enable = true;

  time.timeZone = "America/New_York";

  i18n.defaultLocale = "en_US.UTF-8";
  i18n.extraLocaleSettings = {
    LC_ADDRESS = "en_US.UTF-8";
    LC_IDENTIFICATION = "en_US.UTF-8";
    LC_MEASUREMENT = "en_US.UTF-8";
    LC_MONETARY = "en_US.UTF-8";
    LC_NAME = "en_US.UTF-8";
    LC_NUMERIC = "en_US.UTF-8";
    LC_PAPER = "en_US.UTF-8";
    LC_TELEPHONE = "en_US.UTF-8";
    LC_TIME = "en_US.UTF-8";
  };

  nixpkgs.config.allowUnfree = true;

  nix.settings.experimental-features = [ "nix-command" "flakes" ];

  users.users.tarunbod = {
    isNormalUser = true;
    description = "Tarun";
    extraGroups = [ "networkmanager" "wheel" ];
  };
  users.defaultUserShell = pkgs.nushell;

  services.tailscale.enable = true;

  services.openssh.enable = true;
  programs.ssh.startAgent = true;

  networking.firewall.enable = false;

  system.stateVersion = "25.11";

  environment.systemPackages = [
    pkgs.age
    pkgs.bat
    pkgs.btop
    pkgs.carapace
    pkgs.delta
    pkgs.fortune
    pkgs.ffmpeg
    pkgs.go
    pkgs.gh
    pkgs.git
    pkgs.git-lfs
    pkgs.jq
    pkgs.neofetch
    pkgs.neovim

    pkgs.nushell
    pkgs.nushellPlugins.polars
    pkgs.nushellPlugins.query
    pkgs.nushellPlugins.formats

    pkgs.ripgrep
    pkgs.starship
    pkgs.tmux
    pkgs.wget

    agenix.packages.${system}.default
  ];

  users.users.tarunbod.home = homeDir;
  home-manager = {
    useGlobalPkgs = true;
    useUserPackages = true;

    backupFileExtension = "backup";

    sharedModules = [
      agenix.homeManagerModules.default
    ];

    users.tarunbod = {
      home = {
        username = "tarunbod";
        homeDirectory = homeDir;
        stateVersion = "25.05";

        file = {
          bashrc = {
            source = ../../.bashrc;
            target = ".bashrc";
          };
        };
      };

      age = {
        secrets.secrets_json = {
          file = ../../secrets/secrets.age;
          path = "${homeDir}/.secrets.json";
        };
      };
    };
  };
}
