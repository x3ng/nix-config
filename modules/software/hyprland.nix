{ config, pkgs, ... }:

{

  programs.hyprland = {
    enable = true;
    withUWSM = true;
    xwayland.enable = true;
  };

  services.blueman.enable = true;

  environment.systemPackages = with pkgs; [
    hyprpolkitagent
    hyprlock
    hypridle
    hyprshutdown
    rofi
    thunar
    mako
    waybar
    grim
    slurp
    brightnessctl
    playerctl
    networkmanagerapplet
    pavucontrol
    cliphist
    xdg-desktop-portal-hyprland
  ];

  security.wrappers.brightnessctl = {
    source = "${pkgs.brightnessctl}/bin/brightnessctl";
    capabilities = "cap_sys_rawio+ep";
    owner = "root";
    group = "root";
  };

}
