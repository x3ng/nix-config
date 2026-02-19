{ config, pkgs, ... }:

{
  home.username = "xen";
  home.homeDirectory = "/home/xen";

  home.packages = with pkgs;[

    lm_sensors pciutils usbutils

    git fastfetch proxychains-ng wget tmux yazi tree gnused gnutar gawk vim 

    wl-clipboard mihomo

    emacs-pgtk neovim zed-editor calibre thunderbird vlc tigervnc filezilla libreoffice gimp inkscape

    alacritty kitty
    
  ];

  imports = [
    ./modules/xremap/xremap.nix
  ];

  xremap = {
    enable = true;
  };

  home.stateVersion = "25.11";

}
