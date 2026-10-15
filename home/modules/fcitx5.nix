{ pkgs, ... }:

{
  i18n.inputMethod = {
    enable = true;
    type = "fcitx5";
    # UWSM handles the package-provided XDG Autostart entry.
    # Keep toolkit integration and addons, without a second daemon service.
    fcitx5.systemd.enable = false;
    fcitx5.addons = with pkgs; [
      qt6Packages.fcitx5-chinese-addons
      qt6Packages.fcitx5-configtool
    ];
  };

  # Skin resources are read-only data: fcitx5 scans $XDG_DATA_DIRS for
  # fcitx5/themes/*/. Which skin is selected lives in ~/.dotfiles/fcitx5
  # (deployed by ./deploy/deploy fcitx5), not here.
  home.packages = with pkgs; [
    fcitx5-mellow-themes # rounded rectangle, light+dark pairs
    fcitx5-fluent # fluent design with blur/shadow
  ];
}
