{ config, pkgs, ... }:

{
  home.packages = [ pkgs.xremap ];

  systemd.user.services.xremap = {
    Unit.Description = "xremap service";
    Service = {
      Type = "simple";
      ExecStartPre = "${pkgs.bash}/bin/bash -c '"
        + "if [ ! -e /dev/uinput ]; then echo 'ERROR: /dev/uinput not found. Run: sudo modprobe uinput'; exit 1; fi; "
        + "if ! groups | grep -qw input; then echo 'ERROR: user not in input group. Run: sudo usermod -aG input $USER'; exit 1; fi; "
        + "if [ ! -f ${config.xdg.configHome}/xremap/config.yml ]; then echo 'WARN: no config at ${config.xdg.configHome}/xremap/config.yml. Symlink from dotfiles: ln -s ~/.dotfiles/.config/xremap/config.yml ${config.xdg.configHome}/xremap/config.yml'; fi"
        + "'";
      ExecStart = "${pkgs.xremap}/bin/xremap --watch ${config.xdg.configHome}/xremap/config.yml";
      Restart = "on-failure";
      RestartSec = 1;
    };
    Install.WantedBy = [ "default.target" ];
  };
}
