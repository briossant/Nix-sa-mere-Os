
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

  # Configure keymap in X11
  services.xserver = {
    layout = "us";
    xkbVariant = "";
  };

fonts.fonts = with pkgs; [
    powerline-fonts
    terminus_font
];

programs.thunar.enable = true;

services.gvfs.enable = true; # Mount, trash, and other functionalities
services.tumbler.enable = true; # Thumbnail support for images


  # List packages installed in system profile. To search, run:
  # $ nix search wget
  environment.systemPackages = with pkgs; [
    wget
    i3
    firefox
    git-lfs
    nodejs    
    xterm
    python311
    powerline-fonts
    unzip
    cinnamon.pix
    ollama
  ];

  services.xserver = {
    enable = true;

  displayManager = {
    defaultSession = "none+i3";
  };

  windowManager.i3 = {
    enable = true;
    extraPackages = with pkgs; [
      dmenu
      i3status
    ];
  };
  };

  system.stateVersion = "23.05"; # Did you read the comment? yes bb thx u lov u
}
