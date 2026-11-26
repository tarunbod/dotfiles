{ pkgs, username, inputs, ... }:

{
  imports = [
    ./hardware-configuration.nix
  ];

  boot.loader.systemd-boot.enable = true;
  boot.loader.efi.canTouchEfiVariables = true;

  # NESDR SMArt: install RTL-SDR tools/udev rules and blacklist DVB drivers.
  hardware.rtl-sdr.enable = true;

  hardware.graphics = {
    enable = true;
    package = pkgs.mesa;
    extraPackages = with pkgs; [
      vulkan-loader
      vulkan-validation-layers
      vulkan-extension-layer
    ];
  };

  systemd.sleep.settings.Sleep = {
    AllowSuspend = "no";
    AllowHibernation = "no";
    AllowHybridSleep = "no";
    AllowSuspendThenHibernate = "no";
  };

  networking.hostName = "monkey";

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

  users.users."${username}".extraGroups = [ "docker" "plugdev" ];
  users.defaultUserShell = inputs.nushell.packages.${pkgs.stdenv.hostPlatform.system}.nushell.overrideAttrs (oldAttrs: {
    passthru = (oldAttrs.passthru or {}) // {
      shellPath = "/bin/nu";
    };
    doCheck = false;
    doInstallCheck = false;
  });

  environment.systemPackages = [
    pkgs.linuxKernel.packages.linux_zen.nct6687d
    pkgs.awscli2
    pkgs.blender
    pkgs.discord
    pkgs.ghostty
    pkgs.git
    pkgs.glib
    pkgs.google-chrome
    pkgs.gqrx
    pkgs.just
    pkgs.lm_sensors
    pkgs.pnpm
    pkgs.prismlauncher
    pkgs.rocmPackages.rocm-smi
    pkgs.slack
    pkgs.spotify
    pkgs.uni-sync
    pkgs.usbutils
    pkgs.yt-dlp
  ];

  programs.nix-ld.libraries = [
    pkgs.libGL
    pkgs.glib
  ];

  programs.steam.enable = true;

  nixpkgs.config.rocmSupport = true;
  services.ollama.enable = true;

  virtualisation.docker.enable = true;

  services.uni-sync-curve.enable = true;

  services.rex.loginServer = {
    enable = true;
  };

  # This value determines the NixOS release from which the default
  # settings for stateful data, like file locations and database versions
  # on your system were taken. It‘s perfectly fine and recommended to leave
  # this value at the release version of the first install of this system.
  # Before changing this value read the documentation for this option
  # (e.g. man configuration.nix or on https://nixos.org/nixos/options.html).
  system.stateVersion = "24.11"; # Did you read the comment?
}
