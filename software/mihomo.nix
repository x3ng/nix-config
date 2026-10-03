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

  # Mihomo's native TUN integration registers temporary link DNS with resolved.
  # DHCP DNS remains configured and resumes when the TUN link is removed.
  networking.networkmanager.dns = "systemd-resolved";
  networking.networkmanager.unmanaged = [ "interface-name:Mihomo" ];
  services.resolved = {
    enable = true;
    settings.Resolve = {
      DNSSEC = "no";
      DNSOverTLS = "no";
    };
  };

  # NetworkManager enables Polkit. Let the restricted daemon manage only its
  # own link's DNS through Mihomo's native resolved integration.
  security.polkit.extraConfig = ''
    polkit.addRule(function(action, subject) {
      if (subject.user === "mihomo" &&
          action.lookup("interface") === "Mihomo" &&
          [
            "org.freedesktop.resolve1.set-dns-servers",
            "org.freedesktop.resolve1.set-domains",
            "org.freedesktop.resolve1.set-default-route",
            "org.freedesktop.resolve1.revert"
          ].indexOf(action.id) >= 0) {
        return polkit.Result.YES;
      }
    });
  '';

  services.mihomo = {
    enable = true;
    tunMode = true;
    webui = pkgs.metacubexd;
    configFile = "/etc/mihomo/config.yaml";
  };

  systemd.services.mihomo = {
    wantedBy = lib.mkForce [ ];
    requires = [ "systemd-resolved.service" ];
    after = [ "systemd-resolved.service" ];
    serviceConfig = {
      AmbientCapabilities = lib.mkForce [ "CAP_NET_ADMIN" ];
      CapabilityBoundingSet = lib.mkForce [ "CAP_NET_ADMIN" ];
      Restart = "on-failure";
      RestartSec = "1s";
      # AF_UNIX permits the native resolved integration to use D-Bus.
      RestrictAddressFamilies = lib.mkForce "AF_UNIX AF_INET AF_INET6 AF_NETLINK";
    };
  };
}
