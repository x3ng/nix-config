{ config, pkgs, ... }:

{
  home.username = "xen";
  home.homeDirectory = "/home/xen";

  home.packages = with pkgs;[
    gcc
    clang-tools
    python3
    pyright
    racket

    lm_sensors
    pciutils
    usbutils
    git
    gnumake
    cmake
    tmux
    fastfetch
    tree
    gnused
    gnutar
    gawk
    wl-clipboard
    wget
    yazi
    proxychains-ng
    mihomo

    vim
    neovim
    emacs-pgtk

    alacritty
    kitty
    ghostty

    vlc
    tigervnc
    filezilla
    gimp
    aria2
    nyxt
    qutebrowser
    libreoffice
    vscode
    thunderbird
    inkscape
    clash-verge-rev
  ];

  imports = [
    ./modules/xremap/xremap.nix
  ];

  xremap = {
    enable = true;
  };

  home.stateVersion = "25.11";

}
