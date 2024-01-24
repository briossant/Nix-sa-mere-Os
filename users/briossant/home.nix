{ pkgs, config, ... }:
let
    mkImports =  modules: (map  (str: "../../home-modules/" + str) modules);
in {
  imports = mkImports
    [ 
       "vim"
    ];

    # temporary cuz server is down
    manual.manpages.enable = false;

    home.username = "briossant";
    home.homeDirectory = "/home/briossant";

    home.stateVersion = "23.11";
}
