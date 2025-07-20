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

  outputs =
    {
      nixpkgs,
      nix-darwin,
      agenix,
      home-manager,
      ...
    }:
    let
      buildSystem =
        system: extraModules:
        let
          isDarwin = nixpkgs.lib.strings.hasInfix "darwin" system;
          defaultModules =
            if isDarwin then
              [
                ./modules/common-darwin.nix
                home-manager.darwinModules.home-manager
                agenix.darwinModules.default
              ]
            else
              [
                ./modules/common-linux.nix
                home-manager.nixosModules.home-manager
                agenix.nixosModules.default
              ];
          builder = if isDarwin then nix-darwin.lib.darwinSystem else nixpkgs.lib.nixosSystem;
        in
        builder {
          inherit system;
          specialArgs = { inherit agenix; };
          modules = [ ./modules/common.nix ] ++ defaultModules ++ extraModules;
        };
      darwinSystem = buildSystem "aarch64-darwin";
    in
    {
      nixosConfigurations = {
        monkey = buildSystem "x86_64-linux" [
          ./modules/lsp.nix
          ./hosts/monkey/configuration.nix
        ];

        chimp = buildSystem "aarch64-linux" [
          ./hosts/chimp/configuration.nix
        ];
      };

      darwinConfigurations = {
        TMBP = darwinSystem [
          ./modules/lsp.nix
          ./hosts/TMBP/configuration.nix
        ];

        QRLPDYDF2P = darwinSystem [
          ./modules/lsp.nix
          ./hosts/QRLPDYDF2P/configuration.nix
        ];
      };
    };
}
