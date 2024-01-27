{ pkgs, config, ... }:
{
    home.packages = with pkgs; [
        discord
        prismlauncher # minecraft
    ];
}
