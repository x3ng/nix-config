{ pkgs, ... }:

{
  hardware = {
    enableRedistributableFirmware = true;
    firmware = [ pkgs.linux-firmware ];
    enableAllFirmware = true;
  };

  services.fwupd.enable = true;
}
