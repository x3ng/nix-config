{ config, pkgs, ... }:

{

  networking.hostName = "ocean";

  networking.networkmanager = {
    enable = true;
    dns = "systemd-resolved";
  };

  services.resolved = {
    enable = true;
    settings = {
      Resolve = {
        FallbackDNS = [ "223.5.5.5" "119.29.29.29" ];
      };
    };
  };

}
