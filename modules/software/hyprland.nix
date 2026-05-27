{ config, pkgs, ... }:

{

  programs.hyprland = {
    enable = true;
    withUWSM = true;
    xwayland.enable = true;
  };

  environment.systemPackages = with pkgs; [
    hyprpolkitagent
    hyprlock
    hypridle
    hyprshutdown
    rofi
    thunar
    mako
    waybar
    eww
    noctalia-shell
    grim
    slurp
    brightnessctl
  ];

  security.wrappers.brightnessctl = {
    source = "${pkgs.brightnessctl}/bin/brightnessctl";
    capabilities = "cap_sys_rawio+ep";
    owner = "root";
    group = "root";
  };

}
