{pkgs, config, ...}:

# the default x11 config
{
  services.xserver = {
    enable = true;
    layout = "us";
    xkbVariant = "";
    xkbOptions = "caps:escape";
  };
}
