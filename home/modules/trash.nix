{ config, pkgs, ... }:

{
  home.packages = [ pkgs.trash-cli ];

  systemd.user.services.trash-empty = {
    Unit.Description = "trash-empty: remove files older than 30 days";
    Service = {
      Type = "oneshot";
      ExecStart = "${pkgs.trash-cli}/bin/trash-empty 30";
    };
  };

  systemd.user.timers.trash-empty = {
    Unit.Description = "daily trash auto-cleanup";
    Timer = {
      OnCalendar = "daily";
      Persistent = true;
    };
    Install.WantedBy = [ "timers.target" ];
  };
}
