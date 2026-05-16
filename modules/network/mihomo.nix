{ config, pkgs, lib, ... }:

{
  services.mihomo = {
    enable = true;
    tunMode = true;
    webui = pkgs.metacubexd;
    configFile = "/etc/mihomo/config.yaml";
  };

  # default-off: start manually with systemctl start mihomo
  systemd.services.mihomo.wantedBy = lib.mkForce [];
}
