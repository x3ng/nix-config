{ config, pkgs, ... }:

{

  environment.systemPackages = with pkgs; [
    gcc
    python3
    gnumake

    home-manager
  ];

  programs.firefox.enable = true;

}
