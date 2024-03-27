{ config, pkgs, ... }:

{
  imports =
    [
      ./hardware-configuration.nix
      ../../sys-modules/audio
      ../../sys-modules/timezone/kr
    ];

  networking.hostName = "lil-nellie";

  system.stateVersion = "23.11";
}
