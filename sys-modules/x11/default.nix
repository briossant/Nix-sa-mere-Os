{pkgs, globalVars, config, ...}:

# the default x11 config
{
  services.xserver = {
    enable = true;
    layout = "us";
    xkbVariant = "";
    xkbOptions = "caps:escape";
    displayManager.startx.enable = true;
  };
}
