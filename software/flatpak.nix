{ config, pkgs, ... }:

{

  services.flatpak.enable = true;

  systemd.services.flatpak-repo = {
    wantedBy = [ "multi-user.target" ];
    after = [ "network-online.target" "systemd-resolved.service" ];
    wants = [ "network-online.target" ];
    path = [ pkgs.flatpak ];
    script = ''
      flatpak remote-add --if-not-exists flathub https://dl.flathub.org/repo/flathub.flatpakrepo
    '';

    serviceConfig = {
      Restart = "on-failure";
      RestartSec = "3s";
      StartLimitAttempts = 3;
    };
  };

}

