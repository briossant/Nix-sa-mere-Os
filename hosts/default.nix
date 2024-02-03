{ config, pkgs, ... }:

# everything required for every system configs
{
  environment.pathsToLink = [ "/libexec" ];

  boot.loader.systemd-boot.enable = true;
  boot.loader.efi.canTouchEfiVariables = true;

  networking.networkmanager.enable = true;

  nixpkgs.config.allowUnfree = true;

  programs.dconf.enable = true; # for pulse effect

  environment.systemPackages = with pkgs; [
    vim
    git
  ];

  nix.settings.experimental-features = [ "nix-command" "flakes" ];
}
