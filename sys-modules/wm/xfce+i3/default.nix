{ lib, config, pkgs, callPackage, ... }:

{
  imports = [
    ../i3
  ];

  services.xserver = {
    desktopManager = {
      xterm.enable = false;
      xfce = {
        enable = true;
        noDesktop = true;
        enableXfwm = false;
      };
    };
    displayManager.defaultSession = lib.mkDefault "xfce";
  };
}

