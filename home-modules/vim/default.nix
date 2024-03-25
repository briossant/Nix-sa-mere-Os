{ globalVars, pkgs, ... }:


{
  programs.vim = {
    enable = true;
    plugins = with pkgs.vimPlugins; [

      # utils & fun
      markdown-preview-nvim
      vim-fugitive
      vim-wakatime

      # theming
      vim-airline
      vim-airline-themes
      rainbow
      vim-gitgutter
      # gruvbox

      # completion with coc
      coc-nvim
      coc-java
      coc-rust-analyzer # rust
      coc-tabnine # ia suggestions
      coc-tsserver # js & ts
      coc-pyright # python
      coc-ltex # spelling/grammar
      coc-json
      coc-markdownlint
      coc-html
      coc-css

    ];
    extraConfig =
      let
        dm = globalVars.darkmode;
      in
      ''
        let g:airline#extensions#tabline#enabled = 1
        let g:airline_powerline_fonts = 1

        let g:airline_theme=${if dm then "'base16_eighties'"
          else "'solarized'\nlet g:airline_solarized_bg='dark'"}

        syntax on

        set termguicolors
        set background=${if dm then "dark" else "light"}

        " colorscheme gruvbox

        " transparent background
        hi Normal guibg=NONE ctermbg=NONE
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


