{ config, pkgs, lib, ... }:

let
  resolvectl = "${pkgs.systemd}/bin/resolvectl";
in
{
  assertions = [
    {
      assertion = config.networking.networkmanager.enable;
      message = "software/mihomo.nix requires NetworkManager. Also import software/networkmanager.nix.";
    }
  ];

  # =========================================================================
  # DNS 基础设施 — mihomo TUN 模式需要 systemd-resolved 做 DNS 缓冲层
  # 没有 resolved 时，mihomo DNS 故障会导致 100% 20s 超时（无 fallback）
  # sing-box 不需要这些（它有自己的 optimistic DNS），所以放在这里而非 default.nix
  # =========================================================================
  networking.networkmanager.dns = "systemd-resolved";

  services.resolved = {
    enable = true;
    settings = {
      Resolve = {
        FallbackDNS = [ "223.5.5.5" "119.29.29.29" ];
        # mihomo fake-ip 返回合成 IP，DNSSEC 验证会失败导致间歇性 DNS 故障
        DNSSEC = "no";
        # mihomo 已处理加密，resolved 不需要再做 DNS-over-TLS
        DNSOverTLS = "no";
      };
    };
  };

  # =========================================================================
  # mihomo 代理服务
  # =========================================================================
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
      # AF_UNIX: Go runtime internal socketpairs, sd_notify, and D-Bus with systemd-resolved
      # AF_NETLINK: TUN interface management
      RestrictAddressFamilies = lib.mkForce "AF_UNIX AF_INET AF_INET6 AF_NETLINK";
      ExecStopPost = [
        "+${pkgs.writeShellScript "mihomo-dns-cleanup" ''
          # 清除 stale fake-ip 缓存条目
          ${resolvectl} flush-caches 2>/dev/null || true
          # 重置 resolved 的上游服务器状态，让它立刻重新探测而不是记住"不可用"
          ${resolvectl} reset-server-features 2>/dev/null || true
        ''}"
      ];
    };
  };
}
