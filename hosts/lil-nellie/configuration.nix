{ config, pkgs, ... }:

{
  imports =
    [
      ./hardware-configuration.nix
    ];

  networking.hostName = "lil-nellie";

  services.xserver = {
    libinput = {
      touchpad.disableWhileTyping = true;
    };
  };

  system.stateVersion = "23.11";
}
