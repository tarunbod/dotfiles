{
  description = "NixOS config";

  inputs = {
    nixpkgs.url = "github:NixOS/nixpkgs/nixos-25.05";
    nixpkgs-unstable.url = "github:NixOS/nixpkgs/nixos-unstable";

    home-manager.url = "github:nix-community/home-manager/release-25.05";
    home-manager.inputs.nixpkgs.follows = "nixpkgs";

    fenix = {
      url = "github:nix-community/fenix";
      inputs.nixpkgs.follows = "nixpkgs";
    };
  };

  outputs = { self, nixpkgs, nixpkgs-unstable, fenix, home-manager, ... }@inputs: {
    nixosConfigurations = {
      monkey = let
        system = "x86_64-linux";
      in nixpkgs.lib.nixosSystem {
        inherit system;
        specialArgs = {
          inherit inputs;
          unstable = import nixpkgs-unstable {
	          inherit system;
	          overlays = [
	            (final: prev: {
	              rocmPackages = prev.rocmPackages // rec {
	                clr = (prev.rocmPackages.clr.override {
	        	        localGpuTargets = [ "gfx1201" ];
	        	      }).overrideAttrs (oldAttrs: {
	                  passthru = oldAttrs.passthru // {
                      gpuTargets = oldAttrs.passthru.gpuTargets ++ [ "gfx1201" ];
                    };
	                });

	        	      rocminfo = (prev.rocmPackages.rocminfo.override {
	        	        clr = clr;
	        	      });

	        	      rocblas = (prev.rocmPackages.rocblas.override {
	        	        clr = clr;
	        	      });

	        	      rocsparse = (prev.rocmPackages.rocsparse.override {
	        	        clr = clr;
	        	      });

	        	      rocsolver = (prev.rocmPackages.rocsolver.override {
	        	        clr = clr;
	        	      });

	        	      hipblas = (prev.rocmPackages.hipblas.override {
	        	        clr = clr;
	        	      });

	        	      hipblaslt = (prev.rocmPackages.hipblaslt.override {
	        	        clr = clr;
	        	      });
	              };
	            })
	          ];

	          config.allowUnfree = true;
	        };
        };

        modules = [
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
  };
}
