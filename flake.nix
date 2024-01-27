{
  description = "Nix-sa-mere-Os configuration";

  inputs = {
    nixpkgs.url = "github:nixos/nixpkgs/nixos-unstable";
    home-manager.url = "github:nix-community/home-manager";
    home-manager.inputs.nixpkgs.follows = "nixpkgs";
  };

  outputs = inputs@{ nixpkgs, home-manager, ... }: 
    let 
        globalVars = {
            defaultUser = "bcr";
        };
    in let
        mkSystem = { modules }: (
            nixpkgs.lib.nixosSystem {
                modules = modules ++ [
                    ./users
                    ./hosts

                    home-manager.nixosModules.home-manager
                    {
                        home-manager.useGlobalPkgs = true;
                        home-manager.useUserPackages = true;
                        home-manager.users.${globalVars.defaultUser} = 
                            import (./users/${globalVars.defaultUser}/home.nix);

                        home-manager.extraSpecialArgs = { inherit inputs; inherit globalVars; };
                    }

                ];
                system = "x86_64-linux";

                specialArgs = { inherit inputs; inherit globalVars; };
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
