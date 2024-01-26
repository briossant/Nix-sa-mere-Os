
{ config, pkgs, ... }:

{
  imports =
    [ 
      ./hardware-configuration.nix
      ../../sys-modules/audio
      ../../sys-modules/nvidia
      ../../sys-modules/timezone/fr
    ];

  environment.pathsToLink = ["/libexec"];
 
  boot.loader.systemd-boot.enable = true;
  boot.loader.efi.canTouchEfiVariables = true;

  networking.hostName = "mandelBrut"; # Define your hostname.
  networking.networkmanager.enable = true;

  virtualisation.docker.enable = true;
  virtualisation.docker.rootless = {
  enable = true;
  setSocketVariable = true;
};

  # Configure keymap in X11
  services.xserver = {
    layout = "us";
    xkbVariant = "";
  };

  # Define a user account. Don't forget to set a password with ‘passwd’.
  users.users.bcr = {
    isNormalUser = true;
    description = "CS2IsCommingSoon";
    extraGroups = [ "audio"  "networkmanager" "wheel" "docker" ];
    packages = with pkgs; [
	    google-chrome
	    steam
        xfce.thunar	
        lxterminal	
        cura
        python311Packages.pip
        python311Packages.virtualenv
        python311Packages.autopep8     
        julia        
        rlwrap
        feh
        lmms
        vlc
        shutter
        libreoffice
        prismlauncher
        discord

# C programming
        gcc
        gdb
        gnumake
        valgrind
        clang-tools_16
        criterion

        ocaml
        ocamlPackages.ocaml-lsp
        ocamlformat

    ];
  };
fonts.fonts = with pkgs; [
    powerline-fonts
    terminus_font
];
programs.steam = {
  enable = true;
  remotePlay.openFirewall = true; # Open ports in the firewall for Steam Remote Play
  dedicatedServer.openFirewall = true; # Open ports in the firewall for Source Dedicated Server
};

programs.thunar.enable = true;

services.gvfs.enable = true; # Mount, trash, and other functionalities
services.tumbler.enable = true; # Thumbnail support for images


  # Enable automatic login for the user.
  services.getty.autologinUser = "bcr";

  # Allow unfree packages
  nixpkgs.config.allowUnfree = true;

  # List packages installed in system profile. To search, run:
  # $ nix search wget
  environment.systemPackages = with pkgs; [
    vim # Do not forget to add an editor to edit configuration.nix! The Nano editor is also installed by default.
    wget
    i3
    firefox
    git
    git-lfs
    nodejs    
    xterm
    python311
    powerline-fonts
    unzip
    cinnamon.pix
    ollama
  ];
  programs.hyprland.enable = true;

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

  # This value determines the NixOS release from which the default
  # settings for stateful data, like file locations and database versions
  # on your system were taken. It‘s perfectly fine and recommended to leave
  # this value at the release version of the first install of this system.
  # Before changing this value read the documentation for this option
  # (e.g. man configuration.nix or on https://nixos.org/nixos/options.html).
  system.stateVersion = "23.05"; # Did you read the comment?

  nix.settings.experimental-features = [ "nix-command" "flakes" ];

}
