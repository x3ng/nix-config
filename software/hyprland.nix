{
  lib,
  pkgs,
  ...
}:

{
  programs.hyprland = {
    enable = true;
    withUWSM = true;
  };

  xdg.portal.xdgOpenUsePortal = true;
  xdg.portal.extraPortals = [
    pkgs.xdg-desktop-portal-gtk
  ];
  xdg.portal.config.hyprland = {
    default = [
      "hyprland"
      "gtk"
    ];
  };
  programs.dconf.enable = true;

  # Standalone Thunar: https://wiki.nixos.org/wiki/Thunar
  # The NixOS module also enables Xfconf and registers Thunar's services.
  programs.thunar = {
    enable = true;
    plugins = [
      (pkgs.thunar-archive-plugin.overrideAttrs (old: {
        # The plugin searches its own libexec directory; Xarchiver ships its
        # adapter separately, so make it discoverable there.
        postInstall = (old.postInstall or "") + ''
          ln -s ${pkgs.xarchiver}/libexec/thunar-archive-plugin/xarchiver.tap \
            $out/libexec/thunar-archive-plugin/xarchiver.tap
        '';
      }))
    ];
  };
  services.gvfs.enable = true;
  services.tumbler.enable = true;

  # Install the complete runtime here; Quickshell discovers independent user QML.
  # Explicit PAM/portal/GeoClue/greeter integration is system environment only.
  programs.nullshell = {
    enable = true;
    appearance.portal.enable = true;
    appearance.geoclue.enable = true;
    greeter.enable = true;
    greeter.appearance.sourceUser = "xen";
  };

  # NixOS currently omits GeoClue's upstream IP-source defaults. City-level
  # requests need this fallback when Wi-Fi positioning is unavailable.
  environment.etc."geoclue/geoclue.conf".text = lib.mkAfter ''
    [ip]
    enable=true
    method=ichnaea
  '';

  # Bind the optional monitor helper to the graphical session that starts it.
  systemd.user.services.hyprmoncfgd = {
    overrideStrategy = "asDropin";
    partOf = [ "graphical-session.target" ];
  };

  services = {
    logind.settings.Login = {
      HandleLidSwitch = "suspend";
      HandleLidSwitchExternalPower = "lock";
      HandlePowerKey = "suspend";
    };
  };

  environment.systemPackages = with pkgs; [
    # Hyprland-session components; keep these with the optional compositor module.
    hyprmoncfg

    # Toolkit appearance settings for this session without a desktop control center.
    nwg-look
    qt6Packages.qt6ct
    # Qt Widgets style; select Breeze in qt6ct after installation.
    kdePackages.breeze

    # Screenshot and clipboard commands used by the Hyprland bindings/startup.
    grim
    slurp
    satty
    wl-clipboard
    clipse

    # Desktop controls and removable-media automount for this session.
    brightnessctl
    playerctl
    pavucontrol
    udiskie

    # Backend for Thunar's archive plugin, also usable as a standalone GUI.
    xarchiver

    # Session-wide appearance assets are also available to the greeter.
    bibata-cursors
    papirus-icon-theme
  ];
}
