{ lib, globalVars, pkgs, ... }:

{

  programs.alacritty = {
    enable = true;

    settings = {
      env = {
        TERM = "xterm-256color";
      };
      window = {
        title = "Abats-LA-CRITTYques.";
        opacity = lib.mkDefault 0.85;
      };
      scrolling = {
        history = 100000; # le MAX
      };
    };
  };
}
