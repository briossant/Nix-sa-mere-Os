{inputs, home-manager, pkgs, globalVars, ... }:

# global config for all users
{
  imports = [
      ./${globalVars.defaultUser}/configuration.nix
  ];

  # Enable automatic login for the user.
  services.getty.autologinUser = globalVars.defaultUser;
    
  users.users.${globalVars.defaultUser} = {
    isNormalUser = true;
    description = "the default user";
    extraGroups = [ "audio"  "networkmanager" "wheel" ];
    initialPassword = "42";
  };
  
  home-manager.useGlobalPkgs = true; 
  home-manager.useUserPackages = true;
  home-manager.users.${globalVars.defaultUser} = 
    import (./${globalVars.defaultUser}/home.nix);

  home-manager.extraSpecialArgs = { inherit inputs; inherit globalVars; };

}
