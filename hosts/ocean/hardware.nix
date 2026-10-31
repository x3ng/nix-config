{ nixos-hardware, pkgs, ... }:

{
  imports = [
    nixos-hardware.nixosModules.lenovo-thinkpad-t480
    ./hardware-configuration.nix
  ];

  # Local thermal policy in addition to the upstream T480 throttling workaround.
  services.thermald.enable = true;

  hardware.graphics.enable = true;
  services.xserver.videoDrivers = [ "modesetting" ];
  environment.sessionVariables.LIBVA_DRIVER_NAME = "iHD";
  environment.systemPackages = [ pkgs.libva-utils ];

  # Preserve the existing SSD stability workaround: 0 disables NVMe APST.
  # Revisit separately after checking this drive's suspend/resume reliability.
  boot.kernelParams = [ "nvme_core.default_ps_max_latency_us=0" ];
}
