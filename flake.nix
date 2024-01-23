{
  description = "Nix-sa-mere-Os configuration";

  inputs = {
    nixpkgs.url = "github:nixos/nixpkgs/nixos-unstable";
    home-manager.url = "github:nix-community/home-manager";
    home-manager.inputs.nixpkgs.follows = "nixpkgs";
  };

  outputs = inputs@{ nixpkgs, home-manager, ... }: 
    let
        mkSystem = { modules }: (
            nixpkgs.lib.nixosSystem {
                inherit modules;
                system = "x86_64-linux";
            }
        );

        mkHome = { modules }: (
            home-manager.lib.homeManagerConfiguration {
                inherit modules;
            }
        );
    in {
    homeConfigurations = {
        briossant = mkHome {
            modules = [
                ./users/briossant/home.nix
            ];
        };
    };

    nixosConfigurations = {
      mandelBrut = mkSystem {
        modules = [
            ./hosts/mandelBrut/configuration.nix
        ];
      };

      lil-nellie = mkSystem {
        modules = [
          ./hosts/lil-nellie/configuration.nix
        ];
      };
    };
  };
}
