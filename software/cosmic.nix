{ config, pkgs, ... }:

{

  services.displayManager.cosmic-greeter.enable = true;

  services.desktopManager.cosmic.enable = true;

  # Optional: better performance with system76 scheduler
  services.system76-scheduler.enable = true;

  environment.systemPackages = with pkgs; [
    cosmic-ext-applet-caffeine
  ];
}
