{ config, pkgs, ... }:

{

  services.flatpak.enable = true;

  environment.systemPackages = with pkgs; [
    gcc
    python3
    gnumake
    vim
    emacs
    alacritty
    kitty
    wl-clipboard
  ];

  programs.firefox.enable = true;

  virtualisation.docker.enable = true;

}
