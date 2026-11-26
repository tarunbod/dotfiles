{
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

        rex = {
          source = ../rex/init.lua;
          target = ".config/rex/init.lua";
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
  };
}
