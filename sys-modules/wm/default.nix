{ pkgs, config, ... }:

# the default x11 config
{

  services.xserver = {
    libinput = {
      enable = true;
      touchpad.disableWhileTyping = true;
    };


    enable = true;
    layout = "us";
    xkbVariant = "";

    # remap for vim
    xkbOptions = "caps:escape";
  };
}
