{ config, lib, pkgs, globalVars, ... }:

{

  systemd.user.services.wallpaper-changer = {
    Unit = {
      description = "Wallpaper Refresher";
    };
    Service = {
      Type = "oneshot";
      ExecStart = "${pkgs.feh}/bin/feh --no-fehbg --bg-fill --randomize ~/wallpapers/*.JPG";
    };
  };

  systemd.user.timers.wallpaper-changer = {
    Unit = {
      description = "Wallpaper Cycler";
      wants = [ "display-manager.service" ];
      after = [ "graphical-session.target" ];
    };
    Install = {
      wantedBy = [ "graphical-session.target" ];
    };
    Timer = {
      Unit = "wallpaper-changer.service";
      OnCalendar = "*-*-* *:*:00";
      Persistent = true;
    };
  };
}
