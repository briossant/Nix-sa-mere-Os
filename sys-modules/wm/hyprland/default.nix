{ pkgs, ... }:

{
  imports = [
    ../default.nix
  ];
  programs.hyprland = {
    enable = true;
    xwayland.enable = true;
  };
}
