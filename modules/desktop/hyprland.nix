{ config, pkgs, ... }:

{

  programs.hyprland = {
    enable = true;
    withUWSM = true;
    xwayland.enable = true;
  };

  environment.systemPackages = with pkgs; [
    rofi
    thunar
    mako
    waybar
    noctalia-shell
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
