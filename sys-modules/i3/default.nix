{ pkgs, ... }: {
  imports = [
    ../x11
  ];

  services.xserver = {
    windowManager.i3 = {
      enable = true;
    };
      services.xserver.displayManager.defaultSession = "none+i3";
  };
}
