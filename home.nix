{ config, pkgs, ... }:

{
  home.packages = with pkgs;[
    tmux
    tree
    gnused
    gnutar
    gawk

    lm_sensors
    pciutils
    usbutils

    git
    fastfetch
    proxychains-ng
    wget

    neovim
    yazi
    mihomo
    zed-editor
    calibre
    thunderbird
  ];

  home.stateVersion = "25.11";

}
