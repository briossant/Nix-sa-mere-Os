{
  description = "Nix-sa-mere-Os configuration";

  inputs = {
    nixpkgs.url = "github:nixos/nixpkgs/nixos-unstable";
    home-manager.url = "github:nix-community/home-manager";
    home-manager.inputs.nixpkgs.follows = "nixpkgs";
  };

  outputs = inputs@{ nixpkgs, home-manager, ... }: {
    nixosConfigurations = {
    
      networking.hostName = "Nix-sa-mere-Os";      

      nixos-dev = nixpkgs.lib.nixosSystem {
        system = "x86_64-linux";
        modules = [
          ./sys/dev.nix

          home-manager.nixosModules.home-manager
          {
            home-manager.useGlobalPkgs = true;
            home-manager.useUserPackages = true;

            home-manager.users.lil-nellie = import ./users/lil-nellie.nix;
          }
        ];
      };
    };
  };
}
