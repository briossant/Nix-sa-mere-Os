{ pkgs, ... }:

{
  # compositor for transparent background
  services.picom.enable = true;

  programs.alacritty = {
    enable = true;

    settings = {
      import = [ pkgs.alacritty-theme.gruvbox_light ];
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
