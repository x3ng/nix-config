{ config, pkgs, ... }:

{
  # kde
  services.displayManager.sddm.enable = true;
  services.desktopManager.plasma6.enable = true;

  # hyprland
  programs.hyprland.enable = true;

  environment.systemPackages = with pkgs; [
    rofi
    thunar
    mako
    waybar
    grim
  ];
}
