{ config, pkgs, ... }:
{

  environment.systemPackages = with pkgs; [

    home-manager

  ];

  programs.firefox.enable = true;

}
