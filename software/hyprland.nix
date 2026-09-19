{ pkgs, ... }:

{
  programs.hyprland = {
    enable = true;
    withUWSM = true;
  };

  # Hyprland enables and configures its screen-sharing and GTK portals.
  xdg.portal.xdgOpenUsePortal = true;

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
    # Hyprland ecosystem
    hyprpolkitagent
    hyprlock
    hypridle
    hyprshutdown
    hyprmoncfg

    anyrun

    # Desktop shell; runtime behavior and appearance are configured in dotfiles.
    noctalia-shell

    # Qt theming
    qt6Packages.qt6ct

    # Cursor theme
    bibata-cursors

    # Icon theme
    papirus-icon-theme

    # Screenshot + annotation
    grim
    slurp
    satty

    # Clipboard history
    clipse

    # Hardware controls
    brightnessctl
    playerctl
    pavucontrol

    # Auto-mount USB
    udiskie
  ];
}
