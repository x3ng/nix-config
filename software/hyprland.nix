{ lib, pkgs, ... }:

{
  programs.hyprland = {
    enable = true;
    withUWSM = true;
  };

  xdg.portal.xdgOpenUsePortal = true;
  xdg.portal.extraPortals = [ pkgs.darkman ];
  xdg.portal.config.hyprland = {
    default = [ "hyprland" "gtk" ];
    "org.freedesktop.impl.portal.Settings" = [ "darkman" ];
  };
  services.dbus.packages = [ pkgs.darkman ];
  environment.etc."xdg/darkman/config.yaml".text = ''
    usegeoclue: true
    portal: true
  '';

  # Allow the background theme service without a permission prompt.
  services.geoclue2 = {
    enable = true;
    # GeoClue requires an agent before GetClient can complete.
    enableDemoAgent = true;
    appConfig.darkman = {
      isAllowed = true;
      isSystem = true;
    };
  };

  # Preserve GeoClue's upstream IP fallback (the NixOS module omits this section).
  environment.etc."geoclue/geoclue.conf".text = lib.mkAfter ''
    [ip]
    enable=true
    method=ichnaea
  '';

  # Extend the packaged service; its Type, BusName and ExecStart stay upstream.
  systemd.user.services.darkman = {
    wantedBy = [ "graphical-session.target" ];
    partOf = [ "graphical-session.target" ];
    after = [ "graphical-session.target" ];
  };

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
