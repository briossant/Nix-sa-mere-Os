{ config, lib, pkgs, globalVars, ... }:

# make sure that x11 is enabled
let
  mod = "Mod4";
  thm = globalVars.theme;
  # class                 border  backgr. text    indicator child_border
  mkColor = color: "${color.bg} ${color.bg} ${color.text} ${color.bg} ${color.bg}";
in
{
  xsession.enable = true;

  xsession.windowManager.i3 = {
    enable = true;
    config = {
      modifier = mod;

      keybindings = lib.mkOptionDefault {
        # Focus
        "${mod}+h" = "focus left";
        "${mod}+j" = "focus down";
        "${mod}+k" = "focus up";
        "${mod}+l" = "focus right";

        # Move
        "${mod}+Shift+h" = "move left";
        "${mod}+Shift+j" = "move down";
        "${mod}+Shift+k" = "move up";
        "${mod}+Shift+l" = "move right";

        "XF86AudioMute" = "exec amixer set Master toggle";
        "XF86AudioLowerVolume" = "exec amixer set Master 4%-";
        "XF86AudioRaiseVolume" = "exec amixer set Master 4%+";
        "XF86MonBrightnessDown" = "exec brightnessctl set 4%-";
        "XF86MonBrightnessUp" = "exec brightnessctl set 4%+";
        "${mod}+Shift+x" = "exec systemctl suspend";
      };

      terminal = globalVars.terminal;

      startup = [
        {
          command = "exec i3-msg workspace 1";
          always = true;
          notification = false;
        }
        {
          command = "${pkgs.feh}/bin/feh --no-fehbg --bg-fill --randomize ~/wallpapers/*.JPG";
          always = true;
          notification = false;
        }
      ];

      bars = [
        {
          position = "top";
          # fonts = {
          # names = [ "nerdfonts" ];
          # size = 20.0;
          #};

          # No need to specify path for settings file for i3status bar.
          # By default i3status will look for config files at specific paths.
          # I have a seperate file with definitions for i3status bar and it will
          # generate a config file for i3status to look at.
          statusCommand = "${pkgs.i3status}/bin/i3status";
          colors =
            let
              mkBarColor = c: {
                border = c.bg;
                background = c.bg;
                text = c.text;
              };
            in
            {
              background = thm.secondary.bg;
              # separator = "#757575";

              focusedWorkspace = mkBarColor thm.main;
              inactiveWorkspace = mkBarColor thm.off;
              urgentWorkspace = mkBarColor thm.warning;
            };
        }

      ];
    };
    extraConfig = ''
      client.focused ${mkColor thm.main}       
      client.focused_inactive ${mkColor thm.secondary}       
      client.placeholder  ${mkColor thm.warning}        
      client.urgent  ${mkColor thm.warning}        
      client.unfocused ${mkColor thm.off}
      client.background ${thm.extra.bg}
    '';


  };
}


