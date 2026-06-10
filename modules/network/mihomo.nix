{ config, pkgs, lib, ... }:

let
  resolvectl = "${pkgs.systemd}/bin/resolvectl";
in
{
  services.mihomo = {
    enable = true;
    tunMode = true;
    webui = pkgs.metacubexd;
    configFile = "/etc/mihomo/config.yaml";
  };

  # default-off: start on demand
  # DNS is handled by mihomo's TUN dns-hijack (config.yaml), no need to touch system DNS
  systemd.services.mihomo = {
    wantedBy = lib.mkForce [];

    serviceConfig = {
      # AF_UNIX for local API socket
      RestrictAddressFamilies = lib.mkForce "AF_UNIX AF_INET AF_INET6 AF_NETLINK";
      ExecStopPost = [
        "+${pkgs.writeShellScript "mihomo-dns-cleanup" ''
          # mihomo TUN dns-hijack handles DNS internally, does not modify system DNS
          # Only flush caches to clear any stale fake-ip entries
          ${resolvectl} flush-caches 2>/dev/null || true
        ''}"
      ];
    };
  };

  # system/mixed TUN stacks use kernel TCP path, need rp_filter off
  services.udev.extraRules = ''
    ACTION=="add", SUBSYSTEM=="net", ENV{ID_NET_DRIVER}=="tun", RUN+="${pkgs.procps}/bin/sysctl -w net.ipv4.conf.$env{INTERFACE}.rp_filter=0"
  '';
}
