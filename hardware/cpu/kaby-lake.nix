{ config, lib, ... }:

{
  hardware.cpu.intel.updateMicrocode = lib.mkDefault config.hardware.enableRedistributableFirmware;

  services.thermald.enable = true;

  # ThinkPad T480 CPU throttling fix
  services.throttled.enable = true;

  boot.kernelModules = [ "kvm-intel" ];
}