{ config, pkgs, ... }:

{
  imports =
    [
      ./hardware-configuration.nix
      ../../sys-modules/audio
      ../../sys-modules/timezone/fr
    ];

  networking.hostName = "lil-nellie";


  system.stateVersion = "23.11";
}
