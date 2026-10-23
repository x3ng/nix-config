{
  config,
  ...
}:

{
  services.tailscale = {
    enable = true;
    openFirewall = true;
    useRoutingFeatures = "client";

    # Apply preferences independently of interactive login and stored credentials.
    extraSetFlags = [
      "--accept-dns=false"
    ];
  };

  networking.firewall.interfaces.${config.services.tailscale.interfaceName}.allowedTCPPorts = [
    22
  ];
}
