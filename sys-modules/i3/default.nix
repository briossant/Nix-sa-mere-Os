{ pkgs, ... }: {
  imports = [
    ../x11
  ];

  services.xserver = {
    windowManager.i3 = {
      enable = true;
    };
    desktopManager.default = "none+i3";
  };
}
