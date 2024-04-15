{ config, lib, pkgs, globalVars, ... }:

with config.lib.stylix.colors.withHashtag;

# make sure that x11 is enabled
let
  mod = "Mod4";
  urgent = base08;
  focused = base0B;
  background = base00;
  unfocused = base03;
  text = base07;
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
        {
          command = "systemctl --user start wallpaper-changer.service";
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
            statusline = text;
            focusedWorkspace = {
              background = focused;
              border = background;
              text = text;
            };
            inactiveWorkspace = {
              background = background;
              border = background;
              text = text;
            };
          });

        })

      ];

      colors =
        {
          focused.background = lib.mkForce focused;
          focused.border = lib.mkForce focused;
          focused.childBorder = lib.mkForce focused;
          focused.indicator = lib.mkForce focused;
          focused.text = lib.mkForce text;
          urgent.background = lib.mkForce urgent;
          focusedInactive.background = lib.mkForce unfocused;
        };
    };
  };

  programs.i3status = {
    enable = true;
    general = {
      output_format = "i3bar";
      colors = false;
      markup = "pango";
      interval = 5;
      color_good = base0C;
      color_degraded = base0A;
      color_bad = base08;
    };

    modules = {

      /*"cpu_temperature 0" = {
        position = 2;
        settings = {
          format = "<span background='#bf616a'>  %degrees °C </span>";
          path = "/sys/class/thermal/thermal_zone0/temp";
        };
      };*/

      memory = {
        position = 4;
        settings = {
          format = "<span background='${base0B}'> RAM: %used used, rem %available </span>";
          format_degraded = "<span background='${base08}'> RAM < %available </span>";
          threshold_degraded = "2G";
        };
      };

      load = {
        enable = false;
      };

      "disk /" = {
        position = 3;
        settings = {
          format = "<span background='${base0A}'> DISK: %free Free </span>";
        };
      };

      "ethernet _first_" = {
        position = 5;
        settings = {
          format_up = "<span> E: %ip (%speed) </span>";
          format_down = "<span> E: N/A </span>";
        };
      };

      "wireless _first_" = {
        position = 6;
        settings = {
          format_up = "<span> W: (%quality at %essid, %bitrate) %ip </span>";
          format_down = "<span> W: N/A </span>";
        };
      };

      "volume master" = {
        position = 7;
        settings = {
          format = "<span background='${base0C}'> 🎵%volume </span>";
          format_muted = "<span background='${base0C}'> 🔇 Muted </span>";
          device = "default";
          mixer = "Master";
          mixer_idx = 0;
        };
      };

      "battery all" = {
        position = 8;
        settings = {
          last_full_capacity = true;
          format = "<span background='${base0D}'> %status %percentage </span>";
          format_down = "No Battery";
          status_chr = "⚡ CHR";
          status_bat = "🔋 BAT";
          status_unk = "? UNK";
          status_full = "☻ FULL";
          path = "/sys/class/power_supply/BAT%d/uevent";
          low_threshold = 20;
        };
      };

      "tztime local" = {
        position = 9;
        settings = {
          format = "<span background='${base0E}'> %Y-%m-%d %H:%M:%S %Z </span>";
        };
      };

      "tztime paris" = {
        position = 10;
        settings = {
          format = "<span background='${base0F}'> %Y-%m-%d %H:%M:%S %Z </span>";
          timezone = "Europe/Paris";
          hide_if_equals_localtime = true;
        };
      };
    };
  };
}


