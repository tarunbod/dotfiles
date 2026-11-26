{
  config,
  pkgs,
  lib,
  username,
  homeDir,
  ...
}:
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
        run env "PATH=${config.home.path}/bin:$PATH" "${homeDir}/dotfiles/post-activation.nu";
      '';
    };
  };

  age = {
    secrets.secrets_json = {
      file = ../secrets/secrets.age;
      path = "${homeDir}/.secrets.json";
    };
  };
}
