{ lib, pkgs, ... }:

let
  # Package-only adaptation: consumers call the standard gsettings command.
  portalSettings =
    pkgs.runCommand "portal-gsettings"
      {
        nativeBuildInputs = [ pkgs.makeWrapper ];
      }
      ''
        mkdir -p "$out/bin"
        makeWrapper ${pkgs.glib.bin}/bin/gsettings "$out/bin/gsettings" \
          --set GSETTINGS_SCHEMA_DIR "${pkgs.gsettings-desktop-schemas}/share/gsettings-schemas/${pkgs.gsettings-desktop-schemas.name}/glib-2.0/schemas" \
          --prefix GIO_EXTRA_MODULES : "${pkgs.dconf.lib}/lib/gio/modules"
      '';
in
{
  programs.hyprland = {
    enable = true;
    withUWSM = true;
  };

  xdg.portal.xdgOpenUsePortal = true;
  xdg.portal.extraPortals = [ pkgs.xdg-desktop-portal-gtk ];
  xdg.portal.config.hyprland = {
    default = [
      "hyprland"
      "gtk"
    ];
    "org.freedesktop.impl.portal.Settings" = [ "gtk" ];
  };
  programs.dconf.enable = true;

  # Lock screen PAM
  security.pam.services.hyprlock = { };

  # System services
  services = {
    greetd = {
      enable = true;
      settings.default_session = {
        user = "greeter";
        command = "${pkgs.tuigreet}/bin/tuigreet --time --remember --remember-session --asterisks --sessions ${pkgs.hyprland}/share/wayland-sessions";
      };
    };

    upower.enable = true;
    logind.settings.Login = {
      HandleLidSwitch = "suspend";
      HandleLidSwitchExternalPower = "lock";
      HandlePowerKey = "suspend";
    };
  };

  environment.systemPackages = with pkgs; [
    # Hyprland-session components; keep these with the optional compositor module.
    hyprpolkitagent
    hyprlock
    hypridle
    hyprshutdown
    hyprmoncfg
    quickshell
    (lib.hiPrio portalSettings)
    hyprpaper

    # Session-wide appearance assets are also available to the greeter.
    bibata-cursors
    papirus-icon-theme
  ];
}
