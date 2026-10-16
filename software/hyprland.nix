{ lib, pkgs, ... }:

{
  programs.hyprland = {
    enable = true;
    withUWSM = true;
  };

  xdg.portal.xdgOpenUsePortal = true;
  xdg.portal.extraPortals = [
    pkgs.xdg-desktop-portal-gtk
    pkgs.darkman
  ];
  xdg.portal.config.hyprland = {
    default = [
      "hyprland"
      "gtk"
    ];
    "org.freedesktop.impl.portal.Settings" = [ "darkman" ];
  };
  programs.dconf.enable = true;

  # Darkman publishes the application preference; Quickshell observes its socket.
  services.dbus.packages = [ pkgs.darkman ];
  systemd.packages = [ pkgs.darkman ];
  environment.etc."xdg/darkman/config.yaml".text = ''
    usegeoclue: true
    portal: true
  '';
  systemd.user.services.darkman = {
    wantedBy = [ "graphical-session.target" ];
    partOf = [ "graphical-session.target" ];
    after = [ "graphical-session.target" ];
  };

  # Hyprland has no location agent of its own.
  services.geoclue2 = {
    enable = true;
    enableDemoAgent = true;
    appConfig.darkman = {
      isAllowed = true;
      isSystem = true;
    };
  };
  # Include GeoClue's IP fallback, omitted by the NixOS module.
  environment.etc."geoclue/geoclue.conf".text = lib.mkAfter ''
    [ip]
    enable=true
    method=ichnaea
  '';

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
    darkman
    hyprpaper

    # Session-wide appearance assets are also available to the greeter.
    bibata-cursors
    papirus-icon-theme
  ];
}
