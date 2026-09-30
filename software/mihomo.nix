{
  config,
  pkgs,
  lib,
  ...
}:

{
  assertions = [
    {
      assertion = config.networking.networkmanager.enable;
      message = "software/mihomo.nix requires NetworkManager. Also import software/networkmanager.nix.";
    }
  ];

  # NetworkManager supplies DHCP DNS to resolved while mihomo is stopped or running.
  networking.networkmanager.dns = "systemd-resolved";
  services.resolved = {
    enable = true;
    settings.Resolve = {
      DNSSEC = "no";
      DNSOverTLS = "no";
    };
  };

  services.mihomo = {
    enable = true;
    tunMode = true;
    webui = pkgs.metacubexd;
    configFile = "/etc/mihomo/config.yaml";
  };

  systemd.services.mihomo = {
    wantedBy = lib.mkForce [ ];
    serviceConfig = {
      AmbientCapabilities = lib.mkForce [ "CAP_NET_ADMIN" "CAP_NET_BIND_SERVICE" ];
      CapabilityBoundingSet = lib.mkForce [ "CAP_NET_ADMIN" "CAP_NET_BIND_SERVICE" ];
      Restart = "on-failure";
      RestartSec = "1s";
      RestrictAddressFamilies = lib.mkForce "AF_UNIX AF_INET AF_INET6 AF_NETLINK";
    };
  };
}
