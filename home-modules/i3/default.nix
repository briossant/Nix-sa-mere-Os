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
      };

      terminal = globalVars.terminal;

    };
    extraConfig = ''
      client.focused ${mkColor thm.main}       
      client.urgent  ${mkColor thm.warning}        
      client.unfocused ${mkColor thm.off}
    '';
  };
}


