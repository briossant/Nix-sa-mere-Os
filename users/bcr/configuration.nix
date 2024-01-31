{ pkgs, config, globalVars, ... }:

# system level config for the user
{
  # modules
  imports = [
    ../../sys-modules/steam
    ../../sys-modules/wm/${globalVars.wm}
    ../../sys-modules/thunar
  ];
}
