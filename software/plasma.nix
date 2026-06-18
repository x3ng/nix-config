{ config, pkgs, ... }:

{
  services.xserver.enable = true;
  services.xserver.xkb = {
    layout = "us";
    variant = "";
  };

  services.desktopManager.plasma6.enable = true;
  services.displayManager.plasma-login-manager.enable = true;
}
