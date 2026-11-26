{
  description = "NixOS config";

  inputs = {
    nixpkgs.url = "github:NixOS/nixpkgs/nixpkgs-unstable";

    nix-darwin.url = "github:nix-darwin/nix-darwin/master";
    nix-darwin.inputs.nixpkgs.follows = "nixpkgs";

    agenix.url = "github:ryantm/agenix";
    agenix.inputs.nixpkgs.follows = "nixpkgs";

    home-manager.url = "github:nix-community/home-manager/master";
    home-manager.inputs.nixpkgs.follows = "nixpkgs";

    uni-sync-curve.url = "github:tarunbod/uni-sync-curve";
    uni-sync-curve.inputs.nixpkgs.follows = "nixpkgs";

    nushell.url = "github:nushell/nushell?dir=scripts/nix";
    nushell.inputs.nixpkgs.follows = "nixpkgs";

    opencode.url = "github:anomalyco/opencode";
    opencode.inputs.nixpkgs.follows = "nixpkgs";

    rex.url = "https://pkgs.superlogical.com/rex/nix/snapshot.tar.gz";
    rex.inputs.nixpkgs.follows = "nixpkgs";

    datadog.url = "git+ssh://git@github.com/ddoghq/datadog-nix";
    datadog.inputs.nixpkgs.follows = "nixpkgs";
    datadog.inputs.home-manager.follows = "home-manager";
  };

  outputs =
    {
      nixpkgs,
      nix-darwin,
      agenix,
      home-manager,
      uni-sync-curve,
      rex,
      ...
    }@inputs:
    let
      buildSystem =
        username: builder: system: extraModules:
        builder {
          inherit system;
          specialArgs = { inherit username inputs; };
          modules = [ ./modules/common.nix ] ++ extraModules;
        };
      nixosSystem =
        system: extraModules:
        buildSystem "tarunbod" (nixpkgs.lib.nixosSystem) system (
          [
            ./modules/common-linux.nix
            home-manager.nixosModules.home-manager
            agenix.nixosModules.default
          ]
          ++ extraModules
        );
      darwinSystem =
        username: extraModules:
        buildSystem username (nix-darwin.lib.darwinSystem) "aarch64-darwin" (
          [
            ./modules/common-darwin.nix
            home-manager.darwinModules.home-manager
            agenix.darwinModules.default
          ]
          ++ extraModules
        );
    in
    {
      nixosConfigurations = {
        monkey = nixosSystem "x86_64-linux" [
          ./modules/languages.nix
          uni-sync-curve.nixosModules.default
          ./hosts/monkey/configuration.nix
          rex.nixosModules.default
        ];

        chimp = nixosSystem "aarch64-linux" [
          ./hosts/chimp/configuration.nix
        ];
      };

      darwinConfigurations = {
        TMBP = darwinSystem "tarunbod" [
          ./modules/languages.nix
          ./hosts/TMBP/configuration.nix
        ];

        work = darwinSystem "tarun.boddupalli" [
          ./modules/languages.nix
          ./hosts/work/configuration.nix
        ];
      };

      homeConfigurations.tarunbod = home-manager.lib.homeManagerConfiguration {
        pkgs = nixpkgs.legacyPackages.aarch64-linux;
        extraSpecialArgs = { inherit inputs; username = "tarunbod"; homeDir = "/home/tarunbod"; };
        modules = [
          agenix.homeManagerModules.default
          ./modules/home.nix
          ./modules/home-standalone.nix
        ];
      };
    };
}
