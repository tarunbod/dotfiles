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
  };

  outputs = { nixpkgs, nix-darwin, agenix, home-manager, ... }:
    let
      buildSystem = (builder: system: extraModules: builder {
        inherit system;
        specialArgs = { inherit agenix; };
        modules = [
          ./modules/common.nix
        ] ++ extraModules;
      });

      linuxSystem = (system: extraModules: buildSystem
        (nixpkgs.lib.nixosSystem)
        system
        (
          [
            ./modules/common-linux.nix
            home-manager.nixosModules.home-manager
            agenix.nixosModules.default
          ] ++ extraModules
        )
      );

      darwinSystem = (extraModules: buildSystem
        (nix-darwin.lib.darwinSystem)
        "aarch64-darwin"
        (
          [
            ./modules/common-darwin.nix
            home-manager.darwinModules.home-manager
            agenix.darwinModules.default
          ] ++ extraModules
        )
      );
    in
    {
      nixosConfigurations = {
        monkey = linuxSystem "x86_64-linux" ([
          ./modules/lsp.nix
          ./hosts/monkey/configuration.nix
        ]);

        chimp = linuxSystem "aarch64-linux" ([
          ./hosts/chimp/configuration.nix
        ]);
      };

      darwinConfigurations = {
        TMBP = darwinSystem ([
          ./modules/lsp.nix
          ./hosts/TMBP/configuration.nix
        ]);

        QRLPDYDF2P = darwinSystem ([
          ./modules/lsp.nix
          ./hosts/QRLPDYDF2P/configuration.nix
        ]);
      };
    };
}
