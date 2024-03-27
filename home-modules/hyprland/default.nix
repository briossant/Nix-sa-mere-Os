{ pkgs, inputs, ... }:

{
  wayland.windowManager.hyprland = {
    enable = true;

    plugins = [ inputs.hy3.packages.x86_64-linux.hy3 ];

    settings = {
      "$mod" = "SUPER";
      bind =
        [
          "$mod, RETURN, exec, alacritty"
          "$mod, M, exec, firefox"
          "$mod SHIFT, X, exec, systemctl suspend"
          "$mod SHIFT,Q,killactive"

          "$mod,H,movefocus,l"
          "$mod,L,movefocus,r"
          "$mod,K,movefocus,u"
          "$mod,J,movefocus,d"


        ]
        ++ (
          # workspaces
          # binds $mod + [shift +] {1..10} to [move to] workspace {1..10}
          builtins.concatLists (builtins.genList
            (
              x:
              let
                ws =
                  let
                    c = (x + 1) / 10;
                  in
                  builtins.toString (x + 1 - (c * 10));
              in
              [
                "$mod, ${ws}, workspace, ${toString (x + 1)}"
                "$mod SHIFT, ${ws}, movetoworkspace, ${toString (x + 1)}"
              ]
            )
            10)
        );
    };
  };
}
