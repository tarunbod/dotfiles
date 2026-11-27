{ pkgs, inputs, username, ... }:
{
  boot.kernelPackages = pkgs.linuxPackages_latest;

  networking.networkmanager.enable = true;
  networking.firewall.enable = false;
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

  users.users."${username}" = {
    isNormalUser = true;
    description = "Tarun";
    extraGroups = [ "networkmanager" "wheel" ];
  };

  services.tailscale.enable = true;
  services.openssh.enable = true;
  programs.ssh.startAgent = true;

  environment.systemPackages = [
    pkgs.file
    pkgs.gcc
    pkgs.unzip
    pkgs.claude-code
    pkgs.nushell
    pkgs.opencode
  ];

  programs.nix-ld.enable = true;
}
