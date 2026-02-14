{ config, pkgs, lib, ... }:

with lib;

let
  cfg = config.xremap;
in
{
  options.xremap = {
    enable = mkEnableOption "xremap service";
  };

  config = mkIf cfg.enable {
    home.packages = [ pkgs.xremap ];

    systemd.user.services.xremap = {
      Unit.Description = "xremap service";
      Service = {
        Type = "simple";
        ExecStart = "${pkgs.xremap}/bin/xremap --watch ${config.xdg.configHome}/xremap/config.yml";
        Restart = "on-failure";
        RestartSec = 1;
      };
      Install.WantedBy = [ "default.target" ];
    };
  };
}
