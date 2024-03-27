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
          urgent.background = lib.mkForce urgent;
          focusedInactive.background = lib.mkForce unfocused;
        };
    };
  };

  programs.i3status = {
    enable = true;
    general = {
      output_format = "i3bar";
      colors = true;
      markup = "pango";
      interval = 5;
      color_good = base0C;
      color_degraded = base0A;
      color_bad = base08;
    };

    modules = {
      load = {
        position = 1;
        settings = {
          format = "<span background='#f59335'>  %5min Load </span>";
        };
      };

      "cpu_temperature 0" = {
        position = 2;
        settings = {
          format = "<span background='#bf616a'>  %degrees °C </span>";
          path = "/sys/class/thermal/thermal_zone0/temp";
        };
      };

      "disk /" = {
        position = 3;
        settings = {
          format = "<span background='#fec7cd'>  %free Free </span>";
        };
      };

      "disk /home" = {
        position = 4;
        settings = {
          format = "<span background='#a1d569'>  %free Free </span>";
        };
      };

      "ethernet eth0" = {
        position = 5;
        settings = {
          format_up = "<span background='#88c0d0'> E: %ip (%speed) </span>";
          format_down = "<span background='#88c0d0'> E: Disconnected </span>";
        };
      };

      "wireless wlan0" = {
        position = 6;
        settings = {
          format_up = "<span background='#b48ead'> W: (%quality at %essid, %bitrate) %ip </span>";
          format_down = "<span background='#b48ead'> W: Disconnected </span>";
        };
      };

      "volume master" = {
        position = 7;
        settings = {
          format = "<span background='#ebcb8b'> Vol %volume </span>";
          format_muted = "<span background='#ebcb8b'> Muted </span>";
          device = "default";
          mixer = "Master";
          mixer_idx = 0;
        };
      };

      "battery 0" = {
        position = 8;
        settings = {
          last_full_capacity = true;
          format = "<span background='${base0F}'>  %status %percentage </span>";
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
          format = "<span background='#81a1c1'> %Y-%m-%d %H:%M:%S %Z </span>";
          hide_if_equals_localtime = true;
        };
      };

      "tztime paris" = {
        position = 10;
        settings = {
          format = "<span background='#81a1c1'> %Y-%m-%d %H:%M:%S %Z </span>";
          timezone = "Europe/Paris";
        };
      };
    };
  };
}


