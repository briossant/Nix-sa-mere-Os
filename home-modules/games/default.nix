{ pkgs, config, inputs, globalVars, ... }:
let
  # Import the pinned version of prismlauncher
  prismlauncherPkgs = import inputs.prismlauncher {
    system = globalVars.system;
  };
in
{
  home.packages = [
    pkgs.discord
    prismlauncherPkgs.prismlauncher
  ];
}
