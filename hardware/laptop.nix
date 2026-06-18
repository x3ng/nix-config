{ config, lib, ... }:

{
  services.power-profiles-daemon.enable = true;

  hardware.trackpoint.enable = lib.mkDefault true;
  hardware.trackpoint.emulateWheel = lib.mkDefault config.hardware.trackpoint.enable;
}
