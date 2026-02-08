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
    swaylock-effects
    swayidle
    grim
    brightnessctl
  ];

  security.wrappers.brightnessctl = {
    source = "${pkgs.brightnessctl}/bin/brightnessctl";
    capabilities = "cap_sys_rawio+ep";
    owner = "root";
    group = "root";
  };
}
