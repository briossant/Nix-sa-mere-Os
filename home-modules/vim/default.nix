{ globalVars, pkgs, ... }:


{
  programs.vim = {
    enable = true;
    plugins = with pkgs.vimPlugins; [
      coc-rust-analyzer
      markdown-preview-nvim
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
    extraConfig =
      let
        dm = globalVars.darkmode;
      in
      ''
        let g:airline#extensions#tabline#enabled = 1
        let g:airline_powerline_fonts = 1

        let g:airline_theme='${if dm then "base16_eighties"
          else "solarized"}'

        syntax on

        set termguicolors
        set background=${if dm then "dark" else "light"}

        colorscheme gruvbox
      '' + (builtins.readFile ./vimrc);
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
    rust-analyzer
  ];

  home.file = {
    ".vim/coc-settings.json".source = ./coc-settings.json;
  };
}


