{ config, lib, pkgs, globalVars, ... }:

# make sure that x11 is enabled
let
  mod = "Mod4";
  thm = globalVars.theme;
in
{
  imports = [
    ./wallpaper.nix
  ];
  xsession.enable = true;

  # compositor mainly to allow transparency of other programs
  services.picom = {
    enable = true;
  };

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
          command = "${pkgs.picom}/bin/picom";
          always = true;
          notification = false;
        }
      ];

      gaps = {
        outer = 4;
        inner = 6;
      };

      window.border = 2;

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
            {
              background = thm.background.primary;
              # separator = "#757575";

              focusedWorkspace = {
                # tricks to make it apear smaller
                border = thm.background.primary;
                background = thm.active.primary;
                text = thm.active.text;
              };
              inactiveWorkspace = {
                border = thm.unactive.primary;
                background = thm.unactive.primary;
                text = thm.unactive.text;
              };
              urgentWorkspace = {
                border = thm.warning.primary;
                background = thm.warning.secondary;
                text = thm.warning.text;
              };
            };
        }

      ];
    };
    extraConfig =
      let
        # class                 border  backgr. text    indicator child_border
        mkColor = color: "${color.primary} ${color.primary} ${color.text} ${color.primary} ${color.primary}";
      in
      ''
        client.focused ${mkColor thm.active}       
        client.focused_inactive ${mkColor thm.unactive}       
        client.placeholder  ${mkColor thm.good}        
        client.urgent  ${mkColor thm.warning}        
        client.unfocused ${mkColor thm.unactive}
        client.background ${thm.background.primary}
      '';


  };
}


