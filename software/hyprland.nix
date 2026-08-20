{ pkgs, ... }:

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
        command = "${pkgs.tuigreet}/bin/tuigreet --time --remember --remember-session --asterisks --power-shutdown 'systemctl poweroff' --power-reboot 'systemctl reboot'";
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
      default = [
        "hyprland"
        "gtk"
      ];
    };
  };

  # xdg-open should use portal system on Wayland
  xdg.portal.xdgOpenUsePortal = true;

  # Lock screen PAM
  security.pam.services.hyprlock = { };

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
    papirus-icon-theme

    # Launcher
    rofi

    # Notifications
    mako

    # Screenshot + annotation
    grim
    slurp
    satty

    # Clipboard history
    cliphist

    # Wallpaper
    hyprpaper

    # Hardware controls
    brightnessctl
    playerctl
    pavucontrol

    # Auto-mount USB
    udiskie

    # System tray apps
    networkmanagerapplet

    # Display config
    wlr-randr
    nwg-displays
  ];

  security.wrappers.brightnessctl = {
    source = "${pkgs.brightnessctl}/bin/brightnessctl";
    capabilities = "cap_sys_rawio+ep";
    owner = "root";
    group = "root";
  };
}
