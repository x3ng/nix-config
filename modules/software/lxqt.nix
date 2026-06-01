{ config, pkgs, ... }:

{
  services.xserver.desktopManager.lxqt.enable = true;

  # LXQt module only registers X11 session, manually add Wayland session
  services.displayManager.sessionPackages = [ pkgs.lxqt.lxqt-wayland-session ];

  environment.systemPackages = with pkgs; [
    lxqt.lxqt-wayland-session
    lxqt.lxqt-session
    lxqt.lxqt-panel
    lxqt.lxqt-config
    lxqt.pcmanfm-qt
    lxqt.qterminal
    lxqt.lxqt-about
    lxqt.lxqt-admin
    lxqt.lxqt-archiver
    lxqt.lxqt-notificationd
    lxqt.lxqt-policykit
    lxqt.lxqt-powermanagement
    lxqt.lxqt-sudo
    lxqt.lxqt-themes
    lxqt.screengrab
    lxqt.qps
    lxqt.pavucontrol-qt

    labwc
  ];

  services.gvfs.enable = true;
  services.upower.enable = true;
  services.libinput.enable = true;

  xdg.portal.lxqt.enable = true;
  xdg.portal.config.lxqt.default = [ "lxqt" "gtk" ];
}
