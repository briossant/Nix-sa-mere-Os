{ pkgs, config, ... }:
let
 md = ../../modules;
in {
    
  imports =
    [ 
       "${md}/vim"
    ];


    home.username = "lil-nellie";
    home.homeDirectory = "/home/lil-nellie";

    home.stateVersion = "23.11";
}
