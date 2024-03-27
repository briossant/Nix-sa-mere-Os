{ config, lib, pkgs, globalVars, ... }:

with config.lib.stylix.colors.withHashtag;

# make sure that x11 is enabled
let
  mod = "Mod4";
  urgent = base08;
  focused = base0B;
  background = base00;
  unfocused = base03;
  text = base05;
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
        (config.lib.stylix.i3.bar // {
          position = "top";

          statusCommand = "${pkgs.i3status}/bin/i3status";

          colors = (config.lib.stylix.i3.bar.colors // {
            background = background;
            separator = text;
            focusedWorkspace = {
              background = focused;
              border = unfocused;
              text = text;
            };
          });

          extraConfig = (builtins.readFile ./i3status-config);

        })

      ];

      colors =
        {
          focused.background = lib.mkForce focused;
          focused.border = lib.mkForce focused;
          focused.childBorder = lib.mkForce focused;
          focused.indicator = lib.mkForce focused;
          urgent.background = lib.mkForce urgent;
          focusedInactive.background = lib.mkForce unfocused;
        };
    };
  };
}


