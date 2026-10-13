{
  pkgs,
  agenix,
  nushell,
  ...
}:

let
  isDarwin = pkgs.stdenv.hostPlatform.isDarwin;
  homeDir = if isDarwin then "/Users/tarunbod" else "/home/tarunbod";
  # system = pkgs.stdenv.hostPlatform.system;
  # withoutTests = package: package.overrideAttrs (_: { doCheck = false; });
  nushellPkg = nushell.packages.${pkgs.stdenv.hostPlatform.system}.nushell.overrideAttrs (oldAttrs: {
    passthru = (oldAttrs.passthru or { }) // {
      shellPath = "/bin/nu";
    };
    doCheck = false;
    doInstallCheck = false;
  });
in
{
  nixpkgs.config.allowUnfree = true;

  nix.settings.experimental-features = [
    "nix-command"
    "flakes"
  ];

  nix.settings.trusted-users = [
    "root"
    "tarunbod"
  ];

  environment.systemPackages = [
    pkgs.age
    pkgs.bat
    pkgs.btop
    pkgs.bun
    pkgs.cachix
    pkgs.carapace
    pkgs.difftastic
    pkgs.fastfetch
    pkgs.fortune
    pkgs.ffmpeg
    pkgs.go
    pkgs.gh
    pkgs.github-mcp-server
    pkgs.git-lfs
    pkgs.jq
    pkgs.jujutsu
    pkgs.kubectl
    pkgs.neovim
    pkgs.nodejs_24

    # (withoutTests nushell.packages.${system}.nushell)
    # (withoutTests nushell.legacyPackages.${system}.nushellPlugins.polars)
    # (withoutTests nushell.legacyPackages.${system}.nushellPlugins.query)
    # (withoutTests nushell.legacyPackages.${system}.nushellPlugins.formats)

    nushellPkg
    # nushell.legacyPackages.${pkgs.stdenv.hostPlatform.system}.nushellPlugins.polars
    # nushell.legacyPackages.${pkgs.stdenv.hostPlatform.system}.nushellPlugins.query
    # nushell.legacyPackages.${pkgs.stdenv.hostPlatform.system}.nushellPlugins.formats

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
