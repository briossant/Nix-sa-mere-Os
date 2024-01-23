{ pkgs, config, ... }:
let
 md = ../../modules;
in {
    
  imports =
    [ 
       "${md}/vim"
    ];

# temporary cuz server is down
manual.manpages.enable = false;

    home.username = "lil-nellie";
    home.homeDirectory = "/home/lil-nellie";

    home.stateVersion = "23.11";
}
