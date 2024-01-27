{config, pkgs, globalVars}:
{
    
  # Enable automatic login for the user.
  services.getty.autologinUser = globalVars.defaultUser;
    
  # Define a user account. Don't forget to set a password with ‘passwd’.
  users.users.${globalVars.defaultUser} = {
    isNormalUser = true;
    description = "CS2IsCommingSoon";
    extraGroups = [ "audio"  "networkmanager" "wheel" ];
    defaultPassword = "42";
  };
}
