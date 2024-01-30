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
    # font for vim-airline
    powerline-fonts

    ### language servers

    # c
    clang-tools_16

    # nix
    nil
    nixpkgs-fmt

    # ocaml
    ocamlPackages.ocaml-lsp
    ocamlformat
  ];

  home.file = {
    ".vim/coc-settings.json".source = ./coc-settings.json;
  };
}

