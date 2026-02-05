{ config, pkgs, ... }:

let
  homeDir = builtins.getEnv "HOME";
  dotfilesDir = "${homeDir}/.dotfiles";
in
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

  imports = [
    ./modules/xremap/xremap.nix
  ];

  xremap = {
    enable = true;
    dotfilesDir = dotfilesDir;
  };

  home.stateVersion = "25.11";

}
