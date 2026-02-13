{ pkgs, agenix, ... }:

let
  isDarwin = pkgs.stdenv.hostPlatform.isDarwin;
  homeDir = if isDarwin then "/Users/tarunbod" else "/home/tarunbod";
in
{
  nixpkgs.config.allowUnfree = true;

  nix.settings.experimental-features = [
    "nix-command"
    "flakes"
  ];

  nix.settings.trusted-users = [ "root" "tarunbod" ];

  environment.systemPackages = [
    pkgs.age
    pkgs.bat
    pkgs.btop
    pkgs.bun
    pkgs.cachix
    pkgs.carapace
    pkgs.delta
    pkgs.fortune
    pkgs.ffmpeg
    pkgs.go
    pkgs.gh
    pkgs.git-lfs
    pkgs.jq
    pkgs.jujutsu
    pkgs.kubectl
    pkgs.neofetch
    pkgs.neovim
    pkgs.nodejs_24

    pkgs.nushell
    pkgs.nushellPlugins.polars
    pkgs.nushellPlugins.query
    pkgs.nushellPlugins.formats

    pkgs.ripgrep
    pkgs.starship
    pkgs.tmux
    pkgs.wget

    agenix.packages.${pkgs.stdenv.hostPlatform.system}.default
  ];

  users.users.tarunbod.home = homeDir;
  home-manager = {
    useGlobalPkgs = true;
    useUserPackages = true;

    backupFileExtension = "backup";

    sharedModules = [
      agenix.homeManagerModules.default
    ];

    users.tarunbod =
      { lib, ... }:
      {
        home = {
          username = "tarunbod";
          homeDirectory = homeDir;
          stateVersion = "25.05";

          file = {
            zshrc = {
              source = ../.zshrc;
              target = ".zshrc";
            };

            ghostty = {
              target = ".config/ghostty/config";
              text = ''
                font-family = "FiraCode Nerd Font Mono"
                link-url

                theme = "Rose Pine"
                font-size = ${if isDarwin then "12" else "11"}
              '';
            };

            nushell = {
              source = ../config.nu;
              target = ".config/nushell/config.nu";
            };

            starship = {
              source = ../starship.toml;
              target = ".config/starship.toml";
            };
          };

          activation = {
            shell-autoload = lib.hm.dag.entryAfter [ "writeBoundary" ] ''
              run /run/current-system/sw/bin/nu -c "
                let autoload_dir = (\$nu.data-dir | path join 'vendor/autoload');
                mkdir \$autoload_dir;
                /run/current-system/sw/bin/starship init nu | save -f (\$autoload_dir | path join 'starship.nu');
                /run/current-system/sw/bin/carapace _carapace nushell | save -f (\$autoload_dir | path join 'carapace.nu');
                /run/current-system/sw/bin/jj util completion nushell | save -f (\$autoload_dir | path join 'jj.nu');
              ";
            '';
          };
        };

        age = {
          secrets.secrets_json = {
            file = ../secrets/secrets.age;
            path = "${homeDir}/.secrets.json";
          };
        };
      };
  };
}
