{ config, pkgs, ... }:

{

  environment.systemPackages = with pkgs; [ dae daed ];

  systemd.services.dae = {
    description = "Dae Proxy Service";
    after = [ "network-online.target" ];
    wantedBy = [ "multi-user.target" ];

    serviceConfig = {
      ExecStart = "${pkgs.dae}/bin/dae run /etc/dae/config.yaml";
      Restart = "on-failure";

      CapabilityBoundingSet = [ "CAP_NET_ADMIN" "CAP_NET_RAW" ];
      AmbientCapabilities = [ "CAP_NET_ADMIN" "CAP_NET_RAW" ];
      User = "root";
      Group = "root";

      ProtectSystem = "strict";
      ReadWritePaths = [ "/var/lib/dae" "/etc/dae" ];
    };
  };

  systemd.services.daed = {
    description = "Dae Dashboard (WebUI)";
    after = [ "network-online.target" "dae.service" ];
    wants = [ "dae.service" ];
    wantedBy = [ "multi-user.target" ];

    serviceConfig = {
      ExecStart = "${pkgs.daed}/bin/daed";
      Restart = "on-failure";

      Environment = [
        "DAED_LISTEN=0.0.0.0:12345"
      ];

      User = "root";
      Group = "root";
    };
  };

  networking.firewall.allowedTCPPorts = [ 12345 ];

  environment.etc."dae/config.yaml".text = ''
    subscription: []
    rules: []
    proxies: []
  '';
}
