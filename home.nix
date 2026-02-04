{ config, pkgs, ... }:

{

  home.username = "xen";
  home.homeDirectory = "/home/xen";

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
    tigervnc
    filezilla
    vim
    emacs
    alacritty
    kitty
    wl-clipboard
  ];

  home.stateVersion = "25.11";

}
