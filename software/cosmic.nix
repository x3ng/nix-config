{ config, pkgs, ... }:

{
  services.desktopManager.cosmic.enable = true;

  # Optional: better performance with system76 scheduler
  services.system76-scheduler.enable = true;
}
