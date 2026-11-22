{
  pkgs,
  username,
  inputs,
  ...
}:

let
  isDarwin = pkgs.stdenv.hostPlatform.isDarwin;
  homeDir = if isDarwin then "/Users/${username}" else "/home/${username}";
  nuPath = if isDarwin then "/opt/homebrew/bin/nu" else "/run/current-system/sw/bin/nu";
in
{
  nixpkgs.config.allowUnfree = true;

  nix.settings.experimental-features = [
    "nix-command"
    "flakes"
  ];

  nix.settings.trusted-users = [
    "root"
    "${username}"
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
    pkgs.git-lfs
    pkgs.jq
    pkgs.jujutsu
    pkgs.kubectl
    pkgs.neovim
    pkgs.nodejs_24
    pkgs.ripgrep
    pkgs.starship
    pkgs.tmux
    pkgs.wget

    inputs.agenix.packages.${pkgs.stdenv.hostPlatform.system}.default
  ];

  users.users."${username}".home = homeDir;
  home-manager = {
    useGlobalPkgs = true;
    useUserPackages = true;

    backupFileExtension = "backup";

    sharedModules = [
      inputs.agenix.homeManagerModules.default
    ];

    users."${username}" =
      { lib, ... }:
      {
        home = {
          username = "${username}";
          homeDirectory = homeDir;
          stateVersion = "25.05";

          file = lib.mkMerge [
            {
              tmuxconf = {
                source = ../.tmux.conf;
                target = ".tmux.conf";
              };

              nvim = {
                source = ../nvim/init.lua;
                target = ".config/nvim/init.lua";
              };

              nushell = {
                source = ../config.nu;
                target = ".config/nushell/config.nu";
              };

              starship = {
                source = ../starship.toml;
                target = ".config/starship.toml";
              };
            }

            (lib.mkIf (username == "tarunbod") {
              gitconfig = {
                source = ../.gitconfig;
                target = ".gitconfig";
              };
            })
          ];

          activation = {
            shell-autoload = lib.hm.dag.entryAfter [ "writeBoundary" ] ''
              run ${nuPath} -c "
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
