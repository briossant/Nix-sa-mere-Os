{ pkgs, ... }:

{
  home.packages = with pkgs; [
    pulseeffects-legacy # audio filters & effects
    pulsemixer # cli mixer 
  ];
}
