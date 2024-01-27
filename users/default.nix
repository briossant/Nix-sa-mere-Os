{config, pkgs, globalVars, ... }:
{
  # Enable automatic login for the user.
  services.getty.autologinUser = globalVars.defaultUser;
    
  users.users.${globalVars.defaultUser} = {
    isNormalUser = true;
    description = "the default user";
    extraGroups = [ "audio"  "networkmanager" "wheel" ];
    initialPassword= "42";
  };
}
