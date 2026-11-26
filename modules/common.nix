{
  config,
  pkgs,
  username,
  inputs,
  ...
}:

let
  isDarwin = pkgs.stdenv.hostPlatform.isDarwin;
  homeDir = if isDarwin then "/Users/${username}" else "/home/${username}";
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

  environment.systemPackages = import ./cli-packages.nix { inherit pkgs inputs; };

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
        imports = [
          (import ./home.nix {
            inherit
              pkgs
              lib
              username
              homeDir
              ;
          })
        ];

        home.activation.shell-autoload = lib.hm.dag.entryAfter [ "writeBoundary" ] ''
          run env "PATH=${config.system.path}/bin:/opt/homebrew/bin:$PATH" ~/dotfiles/post-activation.nu;
        '';

        age = {
          secrets.secrets_json = {
            file = ../secrets/secrets.age;
            path = "${homeDir}/.secrets.json";
          };
        };
      };
  };
}
