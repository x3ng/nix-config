{ config, pkgs, ... }:

{

  home.username = "xen";
  home.homeDirectory = "/home/xen";

  home.packages = with pkgs;[

    lm_sensors pciutils usbutils

    git fastfetch proxychains-ng wget tmux yazi tree gnused gnutar gawk vim 

    wl-clipboard mihomo

    emacs neovim zed-editor calibre thunderbird tigervnc filezilla

    alacritty kitty
    
  ];

  home.stateVersion = "25.11";

}
