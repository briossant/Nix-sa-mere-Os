{ ... }:

{
  programs.alacritty = {
    enable = true;

    settings = {
      window = {
        title = "Abats-LA-CRITTYques.";
        opacity = 0.8;
      };
      scrolling = {
        history = 100000; # le MAX
      };
    };
  };
}
