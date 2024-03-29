{ config, lib, pkgs, globalVars, ... }:

{

  # use systemctl --user status wallpaper-changer.service
  # for debugging
  systemd.user.services.wallpaper-changer = {
    Unit = {
      Description = "Wallpaper Refresher";
    };
    Service = {
      Type = "oneshot";
      ExecStart = toString (pkgs.writeShellScript "refresh-wallpaper" ''
        #!/bin/bash
        ${pkgs.feh}/bin/feh --no-fehbg --bg-fill --randomize ~/wallpapers/*.JPG
      '');
    };
  };

  # use systemctl --user status wallpaper-changer.timer
  # for debugging
  systemd.user.timers.wallpaper-changer = {
    Unit = {
      Description = "Wallpaper Cycler";
      Wants = [ "display-manager.service" ];
      After = [ "graphical-session.target" ];
    };
    Install = {
      WantedBy = [ "graphical-session.target" ];
    };
    Timer = {
      Unit = "wallpaper-changer.service";
      #   OnCalendar = "*-*-* *:*:00";
      OnBootSec = "1s";
      OnUnitActiveSec = "1m";
      Persistent = true;
    };
  };
}
