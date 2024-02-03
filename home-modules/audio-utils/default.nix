{ pkgs, ... }:

{
  services.pulseeffects.enable = true;

  home.packages = with pkgs; [
    pulsemixer # cli mixer 
  ];
}
