{ pkgs, ... }:

{
  services.pulseeffects.enable = true;

  home.packages = with pkgs; [
    pulsemixer # cli mixer 
  ];

  home.file = {
    ".config/PulseEffects/output/Basic Bass boost + reverb.json".source =
      ./pulseeffect-presets/${"Basic Bass boost + reverb.json"};
  };
}
