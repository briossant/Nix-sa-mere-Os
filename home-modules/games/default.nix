{ pkgs, config, ... }:
{
  imports = [
    ./steam
  ];
  
    home.packages = with pkgs; [
        discord
        prismlauncher # minecraft
    ];
}
