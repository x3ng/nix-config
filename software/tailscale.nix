{ config, pkgs, lib, ... }:

{
  services.tailscale = {
    enable = true;
    openFirewall = true;
    useRoutingFeatures = "client";

    extraUpFlags = [
      "--accept-dns=false"
    ];
  };

  networking.firewall.interfaces.${config.services.tailscale.interfaceName}.allowedTCPPorts = [
    22
  ];
}
