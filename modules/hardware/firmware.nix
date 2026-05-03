{ config, pkgs, ... }:

{

  hardware.firmware = with pkgs; [
    linux-firmware
  ];

  hardware.enableAllFirmware = true;

  hardware.cpu.intel.updateMicrocode = true;
  services.fwupd.enable = true;
  services.thermald.enable = true;

  services.power-profiles-daemon.enable = true;

  services.fstrim.enable = true;

}
