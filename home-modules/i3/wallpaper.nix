{ config, lib, pkgs, globalVars, ... }:

{
  programs.script.changeWallpaper = {
    enable = true;
    content = ''
      #!/usr/bin/env bash
      ${pkgs.feh}/bin/feh --no-fehbg --bg-fill --randomize ~/wallpapers/*.JPG
    '';
  };

  systemd.user.services.wallpaper-changer = {
    enable = true;
    description = "Wallpaper Changer";
    after = [ "graphical.target" ];
    wantedBy = [ "graphical.target" ];
    serviceConfig = {
      Type = "simple";
      ExecStart = "${pkgs.home-manager}/bin/changeWallpaper";
      Restart = "always";
      RestartSec = "60"; # Restart every minute
    };
  };
}
