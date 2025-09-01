{
  description = "NixOS config";

  inputs = {
    nixpkgs.url = "github:NixOS/nixpkgs/nixos-unstable";

    nix-darwin.url = "github:nix-darwin/nix-darwin/master";
    nix-darwin.inputs.nixpkgs.follows = "nixpkgs";

    agenix.url = "github:ryantm/agenix";
    agenix.inputs.nixpkgs.follows = "nixpkgs";
    agenix.inputs.darwin.follows = "nix-darwin";

    home-manager.url = "github:nix-community/home-manager/master";
    home-manager.inputs.nixpkgs.follows = "nixpkgs";

    uni-sync-curve.url = "github:tarunbod/uni-sync-curve";
    uni-sync-curve.inputs.nixpkgs.follows = "nixpkgs";
  };

  outputs =
    {
      nixpkgs,
      nix-darwin,
      agenix,
      home-manager,
      uni-sync-curve,
      ...
    }@inputs:
    let
      buildSystem =
        builder: system: extraModules:
        builder {
          inherit system;
          specialArgs = { inherit agenix inputs; };
          modules = [ ./modules/common.nix ] ++ extraModules;
        };
      nixosSystem =
        system: extraModules:
        buildSystem (nixpkgs.lib.nixosSystem) system (
          [
            ./modules/common-linux.nix
            home-manager.nixosModules.home-manager
            agenix.nixosModules.default
          ]
          ++ extraModules
        );
      darwinSystem =
        extraModules:
        buildSystem (nix-darwin.lib.darwinSystem) "aarch64-darwin" (
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
        ];

        chimp = nixosSystem "aarch64-linux" [
          ./hosts/chimp/configuration.nix
        ];
      };

      darwinConfigurations = {
        TMBP = darwinSystem [
          ./modules/languages.nix
          ./hosts/TMBP/configuration.nix
        ];

        QRLPDYDF2P = darwinSystem [
          ./modules/languages.nix
          ./hosts/QRLPDYDF2P/configuration.nix
        ];
      };
    };
}
