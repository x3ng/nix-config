{ config, pkgs, ... }:

let
  checkScript = pkgs.writeShellScript "xremap-check" ''
    if [ ! -e /dev/uinput ]; then
      echo "ERROR: /dev/uinput not found. Run: sudo modprobe uinput" >&2
      exit 1
    fi
    if [ ! -f /etc/xremap/config.yml ]; then
      echo "ERROR: /etc/xremap/config.yml not found" >&2
      exit 1
    fi
  '';
in
{
  boot.kernelModules = [ "uinput" ];

  services.udev.extraRules = ''
    KERNEL=="uinput", MODE="0660", GROUP="input", TAG+="uaccess"
  '';

  systemd.services.xremap = {
    description = "xremap key remapper";
    wantedBy = [ "multi-user.target" ];
    serviceConfig = {
      User = "xen";
      Group = "input";
      ExecStartPre = "${checkScript}";
      ExecStart = "${pkgs.xremap}/bin/xremap --watch=config /etc/xremap/config.yml";
      Restart = "on-failure";
      RestartSec = 2;
    };
    startLimitBurst = 3;
    startLimitIntervalSec = 30;
  };
}
