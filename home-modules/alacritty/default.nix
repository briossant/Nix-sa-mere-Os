{ lib, globalVars, pkgs, ... }:

{
  # compositor for transparent background on i3 (doesn't work)
  services.picom = {
    enable = globalVars.wm == "i3" && false; # remove the '&& false' later when want to fix

    opacityRules = [ "80:class_g = 'Alacritty'" ];
    backend = "glx";
    activeOpacity = 1.0;
    inactiveOpacity = 0.8;
  };

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
        # opacity = lib.mkForce 0.8; # doesn't work
      };
      scrolling = {
        history = 100000; # le MAX
      };
    };
  };
}
