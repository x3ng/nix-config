{ config, pkgs, ... }:

{

  networking.hostName = "ocean";

  networking.networkmanager = {
    enable = true;
    dns = "systemd-resolved";
  };

  services.resolved.enable = true;

}
