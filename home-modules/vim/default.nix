{ config, pkgs, ... }:


{
  programs.vim = {
    enable = true;
    plugins = with pkgs.vimPlugins; [
      coc-rust-analyzer
      vim-airline
      gruvbox
      coc-nvim
      coc-rust-analyzer
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

    # rust
    rust-analyser
  ];

  home.file = {
    ".vim/coc-settings.json".source = ./coc-settings.json;
  };
}

