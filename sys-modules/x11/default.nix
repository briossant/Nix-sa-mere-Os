{pkgs, globalVars, config, ...}:

# the default x11 config
{
  services.xserver = {
    enable = true;
    layout = "us";
    xkbVariant = "";
    xkbOptions = "caps:escape";
    desktopManager.default = "none";
    displayManager.auto = { enable = true; user = globalVars.defaultUser; };
  };
}
