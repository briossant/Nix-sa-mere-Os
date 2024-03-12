{ globalVars, pkgs, ... }:

{
  # compositor for transparent background
  # services.picom.enable = true;

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
        opacity = 0.8;
      };
      scrolling = {
        history = 100000; # le MAX
      };
      colors = {
        transparent_background_colors = true;
      };
    };
  };
}
