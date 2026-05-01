{ config, pkgs, lib, ... }:

{
  services.mihomo = {
    enable = true;
    tunMode = true;
    webui = pkgs.metacubexd;
    configFile = "/etc/mihomo/config.yaml";
  };

  # start on demand only
  systemd.services.mihomo.wantedBy = lib.mkForce [];

  environment.etc."mihomo/config.yaml".text = ''
    mixed-port: 7890
    external-controller: 127.0.0.1:9090
    mode: rule
    log-level: info
    tun:
      auto-route: true
      auto-detect-interface: true
    dns:
      enable: true
      enhanced-mode: fake-ip
      fake-ip-range: 198.18.0.1/16
      nameserver:
        - 223.5.5.5
        - 119.29.29.29
      fallback:
        - 8.8.8.8
        - 1.1.1.1
      fallback-filter:
        geoip: true
        geoip-code: CN
    proxies: []
    proxy-groups:
      - name: PROXY
        type: select
        proxies:
          - DIRECT
    rules:
      - GEOIP,CN,DIRECT
      - MATCH,PROXY
  '';

  environment.systemPackages = with pkgs; [
    metacubexd
  ];
}
