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

    rust-overlay.url = "github:oxalica/rust-overlay";
    rust-overlay.inputs.nixpkgs.follows = "nixpkgs";

    uni-sync-curve.url = "github:tarunbod/uni-sync-curve";
    uni-sync-curve.inputs.nixpkgs.follows = "nixpkgs";
    uni-sync-curve.inputs.rust-overlay.follows = "rust-overlay";

    nushell.url = "github:nushell/nushell?dir=scripts/nix";
    nushell.inputs.nixpkgs.follows = "nixpkgs";
    nushell.inputs.rust-overlay.follows = "rust-overlay";

    opencode.url = "github:anomalyco/opencode";
    opencode.inputs.nixpkgs.follows = "nixpkgs";

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
      nushell,
      opencode,
      ...
    }@inputs:
    let
      buildSystem =
        username: builder: system: extraModules:
        builder {
          inherit system;
          specialArgs = { inherit username agenix nushell opencode inputs; };
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
    };
}
