{ pkgs, ... }:

{
  home.packages = with pkgs; [
    easyeffects # audio filters & effects
    pulsemixer # gui mixer 
  ];
}
