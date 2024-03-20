{ pkgs, config, globalVars, ... }:
let
  mkImports = modules: (map (path: ../../home-modules/${path}) modules);
in
{

  #modules
  imports = mkImports
    [
      "vim"
      "bash"
      "games"
      "alacritty"
      "audio-utils"
      globalVars.wm
    ];

  # temporary cuz server is down
  # manual.manpages.enable = false;

  home.username = "bcr";
  home.homeDirectory = "/home/bcr";

  home.stateVersion = "23.11";

  home.packages = with pkgs; [

    # browser
    google-chrome
    firefox

    # utils & shell things
    lxterminal
    rlwrap
    feh
    git-lfs
    unzip
    brightnessctl
    xsel

    # desktop
    cinnamon.pix
    cura
    shutter
    libreoffice
    lmms
    vlc

    # ia
    ollama

    # C programming
    gcc
    gdb
    gnumake
    valgrind

    # rust
    rustc
    cargo

    # javascript
    nodejs

    # ocaml
    ocaml

    # python
    python311
    python311Packages.pip
    python311Packages.virtualenv
    python311Packages.autopep8
  ];
}
