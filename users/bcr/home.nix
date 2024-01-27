{ pkgs, config, ... }:
let
    mkImports =  modules: (map  (str: "../../home-modules/" + str) modules);
in {
  imports = mkImports
    [ 
       "vim"
    ];

    # temporary cuz server is down
    # manual.manpages.enable = false;

    home.username = "bcr";
    home.homeDirectory = "/home/bcr";

    home.stateVersion = "23.11";

    home.packages = with pkgs; [
	    google-chrome
	    steam
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
        prismlauncher
        discord

# C programming
        gcc
        gdb
        gnumake
        valgrind
        clang-tools_16
        criterion

        ocaml
        ocamlPackages.ocaml-lsp
        ocamlformat
    ];
}
