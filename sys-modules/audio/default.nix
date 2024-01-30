{ ... }:
{
  hardware.pulseaudio.enable = false;
  nixpkgs.config.pulseaudio = true;

  sound.enable = true;
  security.rtkit.enable = true;
  services.pipewire = {
    enable = true;
    alsa.enable = true;
    alsa.support32Bit = true;
    pulse.enable = true;
  };
}
