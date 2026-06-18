{ config, pkgs, ... }:

{
  hardware.firmware = [ pkgs.linux-firmware ];
  hardware.enableAllFirmware = true;

  services.fwupd.enable = true;
  services.fstrim.enable = true;
}
