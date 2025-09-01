{ pkgs, ... }:

{
  imports = [
    ./hardware-configuration.nix
  ];

  boot.loader.systemd-boot.enable = true;
  boot.loader.efi.canTouchEfiVariables = true;

  boot.kernelPackages = pkgs.linuxPackages_latest;

  hardware.graphics = {
    enable = true;
    enable32Bit = true;
  };

  systemd.sleep.extraConfig = ''
    AllowSuspend=no
    AllowHibernation=no
    AllowHybridSleep=no
    AllowSuspendThenHibernate=no
  '';

  networking.hostName = "monkey";

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

  services.desktopManager.plasma6.enable = true;
  services.displayManager.sddm.enable = true;
  services.displayManager.sddm.wayland.enable = true;

  services.pulseaudio.enable = false;
  security.rtkit.enable = true;
  services.pipewire = {
    enable = true;
    alsa.enable = true;
    alsa.support32Bit = true;
    pulse.enable = true;
  };

  users.users.tarunbod = {
    isNormalUser = true;
    description = "Tarun";
    extraGroups = [ "networkmanager" "wheel" "docker" ];
  };
  users.defaultUserShell = pkgs.nushell;

  environment.systemPackages = [
    pkgs.linuxKernel.packages.linux_zen.nct6687d
    pkgs.awscli2
    pkgs.blender-hip
    pkgs.discord
    pkgs.gcc
    pkgs.ghostty
    pkgs.git
    pkgs.glib
    pkgs.google-chrome
    pkgs.lm_sensors
    pkgs.nodejs_24
    pkgs.pnpm_9

    pkgs.rocmPackages.rocm-smi

    pkgs.spotify
    pkgs.uni-sync
    pkgs.yt-dlp
  ];

  programs.nix-ld.libraries = [
    pkgs.libGL
    pkgs.glib
  ];

  nixpkgs.config.rocmSupport = true;
  services.ollama.enable = true;

  services.tailscale.enable = true;

  virtualisation.multipass.enable = true;

  virtualisation.docker.enable = true;

  services.openssh.enable = true;
  programs.ssh.startAgent = true;

  services.uni-sync-curve.enable = true;

  networking.firewall.enable = false;

  # This value determines the NixOS release from which the default
  # settings for stateful data, like file locations and database versions
  # on your system were taken. It‘s perfectly fine and recommended to leave
  # this value at the release version of the first install of this system.
  # Before changing this value read the documentation for this option
  # (e.g. man configuration.nix or on https://nixos.org/nixos/options.html).
  system.stateVersion = "24.11"; # Did you read the comment?
}
