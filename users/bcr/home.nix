{ pkgs, config, globalVars, ... }:
let
  mkImports = modules: (map  (path: ../../home-modules/${path}) modules);
in {

  #modules
  imports = mkImports
    [ 
        "vim"
        "games"
        "alacritty"
        globalVars.wm
    ];

    # temporary cuz server is down
    # manual.manpages.enable = false;

    home.username = "bcr";
    home.homeDirectory = "/home/bcr";

    home.stateVersion = "23.11";

    home.packages = with pkgs; [
	    google-chrome
        xfce.thunar	
        lxterminal	
        cura
        python311Packages.pip
        python311Packages.virtualenv
        python311Packages.autopep8     
        rlwrap
        feh
        lmms
        vlc
        shutter
        libreoffice

# C programming
        gcc
        gdb
        gnumake
        valgrind
        criterion

        ocaml
    ];
}
