{ config, pkgs, ... }:

{
  programs.vim = {
    enable = true;
    plugins = with pkgs.vimPlugins; [ 
	  vim-airline
      gruvbox
	  coc-nvim 
	  vim-airline-themes
	  vim-fugitive
	  vim-wakatime
	  rainbow
	  vim-gitgutter
    ];
    extraConfig = (builtins.readFile ./vimrc);
  };

  home.packages = with pkgs; [
    powerline-font
  ];
}

