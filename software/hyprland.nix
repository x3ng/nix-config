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
    useTextGreeter = true;
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
      pkgs.xdg-desktop-portal-gtk
    ];
    config.common = {
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
    hyprmoncfg

    # Shell / bar — runtime behavior and appearance are configured in dotfiles.
    quickshell

    # Keep the GTK/XCursor assets selected in dotfiles available system-wide.
    kdePackages.breeze
    kdePackages.breeze-icons

    # Notifications
    mako

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

    # System tray apps
    networkmanagerapplet

    # Display config
    wlr-randr
  ];

  security.wrappers.brightnessctl = {
    source = "${pkgs.brightnessctl}/bin/brightnessctl";
    capabilities = "cap_sys_rawio+ep";
    owner = "root";
    group = "root";
  };
}
