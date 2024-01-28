{ pkgs, globalVars, ... }: {
  imports = [
    ../default.nix
  ];

  services.xserver = {
    windowManager.i3 = {
      enable = true;
    };

    # auto start i3
    displayManager = {
      defaultSession = "none+i3";
      autoLogin = {
        enable = true;
        user = globalVars.defaultUser;
      };
      lightdm.enable = true;
    };
  };
}
