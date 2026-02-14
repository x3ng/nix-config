{ config, pkgs, ... }:

{

  networking.hostName = "ocean";

  services.smartdns = {
    enable = true;
    settings = {
      bind = "127.0.0.1:53";
      server = [
        "119.29.29.29"
        "223.5.5.5"
        "114.114.114.114"
        "8.8.8.8"
        "1.1.1.1"
      ];
      speed-check-mode = "ping,tcp:80,tcp:443";
      cache-size = 8192;
    };
  };

  networking.networkmanager = {
    enable = true;
    dns = "none";
  };

  networking.nameservers = [ "127.0.0.1" ];

}
