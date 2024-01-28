{pkgs, config, ...}:

# the default x11 config
{
  services.xserver = {
    enable = true;
    layout = "us";
    xkbVariant = "";

    # remap for vim
    xkbOptions = "caps:escape";
  };
}
