{ config, pkgs, ... }:

{
  programs.hyprland = {
    enable = true;
    withUWSM = true;
    xwayland.enable = true;
  };

  # Display manager
  services.greetd = {
    enable = true;
    settings = {
      default_session = {
        command = "${pkgs.tuigreet}/bin/tuigreet --time --cmd Hyprland";
        user = "greeter";
      };
    };
  };

  # Screen sharing + file picker portals
  xdg.portal = {
    enable = true;
    extraPortals = [
      pkgs.xdg-desktop-portal-hyprland
      pkgs.xdg-desktop-portal-gtk
    ];
    config.hyprland = {
      default = [ "hyprland" "gtk" ];
    };
  };

  # Lock screen PAM
  security.pam.services.hyprlock = {};

  # Power management
  services.upower.enable = true;
  services.logind = {
    settings.Login = {
      HandleLidSwitch = "suspend";
      HandleLidSwitchExternalPower = "lock";
      HandlePowerKey = "suspend";
    };
  };

  services.blueman.enable = true;

  environment.systemPackages = with pkgs; [
    # Hyprland ecosystem
    hyprpolkitagent
    hyprlock
    hypridle
    hyprshutdown

    # Shell / bar
    quickshell

    # Launcher + notifications
    fuzzel
    mako

    # Screenshot + annotation
    grim
    slurp
    satty

    # Clipboard
    wl-clipboard
    clipse

    # Hardware controls
    brightnessctl
    playerctl
    pavucontrol

    # System tray apps
    networkmanagerapplet

    # File manager
    thunar

    # Cursor theme
    bibata-cursors

    # Icon theme (needed for tray icons)
    adwaita-icon-theme
  ];

  security.wrappers.brightnessctl = {
    source = "${pkgs.brightnessctl}/bin/brightnessctl";
    capabilities = "cap_sys_rawio+ep";
    owner = "root";
    group = "root";
  };
}
