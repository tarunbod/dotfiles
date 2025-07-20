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

    fenix = {
      url = "github:nix-community/fenix";
      inputs.nixpkgs.follows = "nixpkgs";
    };
  };

  outputs = {
    self,
    nixpkgs,
    nix-darwin,
    agenix,
    home-manager,
    fenix,
    ...
  }@inputs: {
    nixosConfigurations = {
      monkey = nixpkgs.lib.nixosSystem (rec {
        system = "x86_64-linux";
        specialArgs = {
          system = system;
          agenix = agenix;
        };

        modules = [
          ./modules/common.nix
          ./modules/common-linux.nix
          ./modules/lsp.nix
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
          agenix.nixosModules.default
        ];
      });

      chimp = nixpkgs.lib.nixosSystem (rec {
        system = "aarch64-linux";
        specialArgs = {
          system = system;
          agenix = agenix;
        };

        modules = [
          # ./modules/common.nix
          # ./modules/common-linux.nix
          ./hosts/chimp/configuration.nix

          home-manager.nixosModules.home-manager
          agenix.nixosModules.default
        ];
      });
    };

    darwinConfigurations = {
      TMBP = nix-darwin.lib.darwinSystem (rec {
        system = "aarch64-darwin";
        specialArgs = {
          system = system;
          agenix = agenix;
        };

        modules = [
          ./modules/common.nix
          ./modules/common-darwin.nix
          ./modules/lsp.nix
          ./hosts/TMBP/configuration.nix

          home-manager.darwinModules.home-manager
          agenix.darwinModules.default
        ];
      });

      QRLPDYDF2P = nix-darwin.lib.darwinSystem (rec {
        system = "aarch64-darwin";
        specialArgs = {
          system = system;
          agenix = agenix;
        };

        modules = [
          ./modules/common.nix
          ./modules/common-darwin.nix
          ./modules/lsp.nix
          ./hosts/QRLPDYDF2P/configuration.nix

          home-manager.darwinModules.home-manager
          agenix.darwinModules.default
        ];
      });
    };
  };
}
