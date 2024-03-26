{
  description = "Nix-sa-mere-Os configuration";

  inputs = {
    nixpkgs.url = "github:nixos/nixpkgs/nixos-unstable";
    home-manager.url = "github:nix-community/home-manager";
    home-manager.inputs.nixpkgs.follows = "nixpkgs";

    # prismlauncher version 7.2
    prismlauncher.url = "github:nixos/nixpkgs/9957cd48326fe8dbd52fdc50dd2502307f188b0d";

    stylix.url = "github:danth/stylix";
  };

  outputs = inputs@{ nixpkgs, home-manager, ... }:
    let
      # global values which may be access anywhere in the flake
      globalVars = {
        system = "x86_64-linux";
        defaultUser = "bcr";
        terminal = "alacritty";
        wm = "hyprland"; # options are the dir-name at -> sys-modules/wm/*
        darkmode = false;
        stylix-image = ./images/IMG_0278.JPG;
        stylix-scheme = "gruvbox-light-medium.yaml"; # see https://tinted-theming.github.io/base16-gallery/
      };
    in
    let
      mkSystem = { modules }: (
        nixpkgs.lib.nixosSystem {
          modules = modules ++ [
            ./users # default user config, will load globalVars.defaultUser user
            ./hosts # default system config
            home-manager.nixosModules.home-manager # for home manager
            inputs.stylix.nixosModules.stylix
          ];
          system = globalVars.system;

          # transmiting variables to imported modules
          specialArgs = { inherit inputs; inherit globalVars; };
        }
      );

      # not used currently, TODO: add easy user switch with home manager
      mkHome = { modules }: (
        home-manager.lib.homeManagerConfiguration {
          inherit modules;
        }
      );
    in
    {

      # same as previous comment
      homeConfigurations = {
        briossant = mkHome {
          modules = [
            ./users/briossant/home.nix
          ];
        };
      };

      # nixos config for my different devices
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
