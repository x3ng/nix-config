# GNOME desktop — backup desktop environment, not imported by default.
#
# To try it: add `../../software/gnome.nix` to hosts/<host>/default.nix and
# comment out the currently active desktop module (software/cosmic.nix).
#
# Extensions are installed here and enabled per-user in Extension Manager.
# We deliberately do NOT seed org.gnome.shell.enabled-extensions: GSettings
# vendor overrides only change a schema's *default value*, so they silently stop
# having any effect the moment the key is written to dconf (which Extension
# Manager does on the first toggle). Installing + toggling once is honest, and
# keeps the enable-list dynamic instead of frozen in a file that lies.
#
# GDM, portals, polkit, upower, libinput, NetworkManager, gnome-keyring and
# XWayland are all pulled in automatically by the GNOME module.
{ pkgs, ... }:

{
  services = {
    displayManager.gdm.enable = true;
    desktopManager.gnome.enable = true;
  };

  environment.systemPackages = with pkgs; [
    # Needed to enable/disable and install extensions at runtime.
    gnome-extension-manager

    # Trays (clash-verge-rev, localsend, fcitx5) need the StatusNotifierItem
    # host that GNOME removed from core. Toggle it on after first login.
    gnomeExtensions.appindicator
  ];
}
