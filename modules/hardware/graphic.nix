{ config, pkgs, ... }:

{

  hardware.graphics = {
    enable = true;
    extraPackages = with pkgs; [ intel-media-driver ];
  };

  services.xserver.videoDrivers = [ "modesetting" ];

  environment.systemPackages = with pkgs; [
    libva
    libva-utils
    ffmpeg-full
  ];

  environment.sessionVariables = {
    LIBVA_DRIVER_NAME = "iHD";
  };

  boot.kernelParams = [ "i915.enable_guc=3" ];

}
