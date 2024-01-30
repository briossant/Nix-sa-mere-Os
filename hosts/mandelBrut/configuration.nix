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


  system.stateVersion = "23.05"; # Did you read the comment? yes bb thx u lov u
}
