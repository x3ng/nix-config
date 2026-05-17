{ config, pkgs, lib, ... }:

let
  resolvectl = "${pkgs.systemd}/bin/resolvectl";
  ip = "${pkgs.iproute2}/bin/ip";
  awk = "${pkgs.gawk}/bin/awk";
  nmcli = "${pkgs.networkmanager}/bin/nmcli";

  dns-setup = pkgs.writeShellScript "mihomo-dns-setup" ''
    set -e
    IFACE=$(${ip} route show default 2>/dev/null | head -1 | ${awk} '{print $5}')
    if [ -n "$IFACE" ]; then
      echo "$IFACE" > /run/mihomo/dns-iface
      ${resolvectl} dns "$IFACE" 127.0.0.1
      ${resolvectl} domain "$IFACE" '~.'
    fi
  '';

  dns-teardown = pkgs.writeShellScript "mihomo-dns-teardown" ''
    IFACE=$(cat /run/mihomo/dns-iface 2>/dev/null || true)
    if [ -n "$IFACE" ]; then
      DNS=$(${nmcli} -g IP4.DNS device show "$IFACE" 2>/dev/null | tr '\n' ' ')
      if [ -n "$DNS" ]; then
        ${resolvectl} dns "$IFACE" $DNS
        ${resolvectl} domain "$IFACE" ""
      else
        ${resolvectl} revert "$IFACE" 2>/dev/null || true
      fi
    fi
    ${resolvectl} flush-caches 2>/dev/null || true
  '';
in
{
  services.mihomo = {
    enable = true;
    tunMode = true;
    webui = pkgs.metacubexd;
    configFile = "/etc/mihomo/config.yaml";
  };

  # default-off: start manually, DNS routing via resolvectl
  systemd.services.mihomo = {
    wantedBy = lib.mkForce [];

    serviceConfig = {
      AmbientCapabilities = lib.mkForce [ "CAP_NET_ADMIN" "CAP_NET_BIND_SERVICE" ];
      CapabilityBoundingSet = lib.mkForce [ "CAP_NET_ADMIN" "CAP_NET_BIND_SERVICE" ];
      RestrictAddressFamilies = lib.mkForce "AF_UNIX AF_INET AF_INET6 AF_NETLINK";
      RuntimeDirectory = "mihomo";
      ExecStartPre = [ "+${dns-setup}" ];
      ExecStopPost = [ "+${dns-teardown}" ];
    };
  };

  # system/mixed TUN stacks use kernel TCP path, need rp_filter off
  services.udev.extraRules = ''
    ACTION=="add", SUBSYSTEM=="net", ENV{ID_NET_DRIVER}=="tun", RUN+="${pkgs.procps}/bin/sysctl -w net.ipv4.conf.$env{INTERFACE}.rp_filter=0"
  '';
}
