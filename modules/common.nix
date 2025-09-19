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

  environment.systemPackages = [
    pkgs.age
    pkgs.bat
    pkgs.btop
    pkgs.bun
    pkgs.carapace
    pkgs.delta
    pkgs.fortune
    pkgs.ffmpeg
    pkgs.go
    pkgs.gh
    pkgs.git-lfs
    pkgs.jq
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

    agenix.packages.${pkgs.system}.default
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
                mkdir (\$nu.data-dir | path join "vendor/autoload");
                /run/current-system/sw/bin/starship init nu | save -f (\$nu.data-dir | path join 'vendor/autoload/starship.nu');
                /run/current-system/sw/bin/carapace _carapace nushell | save -f (\$nu.data-dir | path join 'vendor/autoload/carapace.nu');
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
