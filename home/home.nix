{ config, pkgs, ... }:

{
  home.username = "xen";
  home.homeDirectory = "/home/xen";

  home.packages = with pkgs;[

    gcc python3 racket

    lm_sensors pciutils usbutils

    gnumake git fastfetch proxychains-ng wget tmux yazi tree gnused gnutar gawk vim

    wl-clipboard mihomo clash-verge-rev

    emacs-pgtk neovim zed-editor calibre thunderbird vlc tigervnc filezilla libreoffice gimp inkscape aria2

    alacritty kitty ghostty
    
  ];

  imports = [
    ./modules/xremap/xremap.nix
  ];

  xremap = {
    enable = true;
  };

  home.stateVersion = "25.11";

}
