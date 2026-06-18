{ config, pkgs, ... }:

{
  hardware.enableRedistributableFirmware = true;
  hardware.firmware = [ pkgs.linux-firmware ];
  hardware.enableAllFirmware = true;

  services.fwupd.enable = true;
}
