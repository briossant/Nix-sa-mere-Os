{ config, pkgs, ... }:

{
environment.variables = { EDITOR = "vim"; };

  environment.systemPackages = with pkgs; [
    ((vim_configurable.override {  }).customize{
      name = "vim";
      vimrcConfig.packages.myplugins = with pkgs.vimPlugins; {
        start = [ 
	vim-airline
	coc-nvim 
	vim-airline-themes
	vim-fugitive
	vim-wakatime
	rainbow
	vim-gitgutter
    ];
      };
      vimrcConfig.customRC = (builtins.readFile ./vimrc);
    }
  )];
}



