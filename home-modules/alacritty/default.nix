{ lib, globalVars, pkgs, ... }:

{

  programs.alacritty = {
    enable = true;

    settings = {
      import = [
        pkgs.alacritty-theme.${if globalVars.darkmode then "gruvbox_dark"
        else "gruvbox_light"}
      ];
      env = {
        TERM = "xterm-256color";
      };
      window = {
        title = "Abats-LA-CRITTYques.";
        opacity = 0.9;
      };
      scrolling = {
        history = 100000; # le MAX
      };
    };
  };
}
