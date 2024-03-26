{ config, lib, pkgs, globalVars, ... }:

with config.lib.stylix.colors.withHashtag;

# make sure that x11 is enabled
let
  mod = "Mod4";
  urgent = base08;
  focused = base0A;
  unfocused = base03;
in
{
  imports = [
    ./wallpaper.nix
  ];
  xsession.enable = true;

  # TODO: remove and use stylix transparency
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
        ({
          position = "top";

          statusCommand = "${pkgs.i3status}/bin/i3status";


          colors = {
            background = unfocused;
            activeWorkspace = {
              background = focused;
              border = unfocused;
            };
          };

        } // config.lib.stylix.i3.bar)

      ];

      colors =
        {
          focused.background = lib.mkForce focused;
          urgent.background = lib.mkForce urgent;
          focusedInactive.background = lib.mkForce unfocused;
          unfocused.background = lib.mkForce unfocused;
        };
    };
  };
}


