{ config, pkgs, ... }:

{
  imports =
    [
      ./hardware-configuration.nix
      ../../sys-modules/audio
      ../../sys-modules/nvidia
      ../../sys-modules/timezone/fr
    ];


  networking.hostName = "mandelBrut"; # Define your hostname.

  system.stateVersion = "23.05"; # Did you read the comment? yes bb thx u lov u
}
