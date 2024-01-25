
{ config, pkgs, ... }:

{
  imports =
    [ 
      ./hardware-configuration.nix
    ];

  boot.loader.systemd-boot.enable = true;
  boot.loader.efi.canTouchEfiVariables = true;

  networking.hostName = "lil-nellie"; 
  networking.networkmanager.enable = true;

  users.users.lil-nellie = {
    isNormalUser = true;
    extraGroups = [ "audio"  "networkmanager" "wheel" ];
  };

  services.xserver = {
    enable = true;
    layout = "us";
    xkbVariant = "";
  };

  services.getty.autologinUser = "lil-nellie";

  nixpkgs.config.allowUnfree = true;
  
  system.stateVersion = "23.11";
}
