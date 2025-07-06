{
  description = "NixOS config";

  inputs = {
    nixpkgs.url = "github:NixOS/nixpkgs/nixos-unstable";

    nix-darwin.url = "github:nix-darwin/nix-darwin/master";
    nix-darwin.inputs.nixpkgs.follows = "nixpkgs";

    home-manager.url = "github:nix-community/home-manager/release-25.05";
    home-manager.inputs.nixpkgs.follows = "nixpkgs";

    fenix = {
      url = "github:nix-community/fenix";
      inputs.nixpkgs.follows = "nixpkgs";
    };
  };

  outputs = { self, nixpkgs, nix-darwin, fenix, home-manager, ... }@inputs: {
    nixosConfigurations = {
      monkey = nixpkgs.lib.nixosSystem {
        system = "x86_64-linux";

        modules = [
          ./modules/common.nix
          ./hosts/monkey/configuration.nix

          ({ pkgs, ... }: {
            nixpkgs.overlays = [ fenix.overlays.default ];
            environment.systemPackages = with pkgs; [
              (fenix.packages.${system}.complete.withComponents [
                "cargo"
                "clippy"
                "rust-src"
                "rustc"
                "rustfmt"
              ])
              rust-analyzer-nightly
            ];
          })

          home-manager.nixosModules.home-manager
        ];
      };
    };

    darwinConfigurations = {
      TMBP = nix-darwin.lib.darwinSystem {
        modules = [
          ./modules/common.nix
          ./modules/common-darwin.nix
          ./hosts/TMBP/configuration.nix

          home-manager.darwinModules.home-manager
        ];
      };
    };
  };
}
