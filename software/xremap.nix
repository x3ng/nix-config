{ pkgs, ... }:

{
  users.groups.xremap = { };

  users.users.xremap = {
    isSystemUser = true;
    group = "xremap";
    extraGroups = [ "input" "uinput" ];
  };

  hardware.uinput.enable = true;

  systemd.services.xremap = {
    description = "xremap key remapper";
    wantedBy = [ "multi-user.target" ];
    serviceConfig = {
      User = "xremap";
      ExecStart = "${pkgs.xremap}/bin/xremap --watch=config /etc/xremap/config.yml";
      Restart = "on-failure";
      RestartSec = 2;
    };
    startLimitBurst = 3;
    startLimitIntervalSec = 30;
  };
}
