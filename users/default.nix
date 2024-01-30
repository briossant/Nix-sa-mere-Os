{ inputs, home-manager, pkgs, globalVars, ... }:

# global config for all users
{

  # import default user system config
  imports = [
    ./${globalVars.defaultUser}/configuration.nix
  ];

  # Enable automatic login for the default user.
  services.getty.autologinUser = globalVars.defaultUser;

  # default user
  users.users.${globalVars.defaultUser} = {
    isNormalUser = true;
    description = "the default user";
    extraGroups = [ "audio" "networkmanager" "wheel" ];
    initialPassword = "42";
  };

  home-manager.useGlobalPkgs = true;
  home-manager.useUserPackages = true;

  # import default user home config
  home-manager.users.${globalVars.defaultUser} =
    import (./${globalVars.defaultUser}/home.nix);

  # transmit values to the home config
  home-manager.extraSpecialArgs = { inherit inputs; inherit globalVars; };

}
