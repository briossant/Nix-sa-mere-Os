
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


  time.timeZone = "Europe/Paris";

  i18n.defaultLocale = "en_US.UTF-8";

  i18n.extraLocaleSettings = {
    LC_ADDRESS = "fr_FR.UTF-8";
    LC_IDENTIFICATION = "fr_FR.UTF-8";
    LC_MEASUREMENT = "fr_FR.UTF-8";
    LC_MONETARY = "fr_FR.UTF-8";
    LC_NAME = "fr_FR.UTF-8";
    LC_NUMERIC = "fr_FR.UTF-8";
    LC_PAPER = "fr_FR.UTF-8";
    LC_TELEPHONE = "fr_FR.UTF-8";
    LC_TIME = "fr_FR.UTF-8";
  };

  users.users.lil-nellie = {
    isNormalUser = true;
    extraGroups = [ "audio"  "networkmanager" "wheel" ];
    hashedPassword =
        "$y$j9T$VEuARXoIfKOJxFZriCvv./$L6hcDNUHBkH2F6OxCfbVpMslijY86/t2Hb35KoMxjB3";
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
