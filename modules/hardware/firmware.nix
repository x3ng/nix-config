{ config, pkgs, ... }:

{

  hardware.firmware = with pkgs; [
    linux-firmware
  ];

  hardware.enableAllFirmware = true;

  hardware.cpu.intel.updateMicrocode = true;
  services.fwupd.enable = true;

}

