{ pkgs, config, inputs, ... }:

{
    home.packages = [
        pkgs.discord
        inputs.prismlauncher.pkgs.prismlauncher # minecraft
    ];
}
