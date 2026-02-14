{ config, pkgs, ... }:

{

  time.timeZone = "Asia/Shanghai";

  i18n = {
    defaultLocale = "en_US.UTF-8";
  };

  hardware.enableRedistributableFirmware = true;

}
