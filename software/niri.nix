{ pkgs, ... }:

{

  programs.niri.enable = true;

  environment.systemPackages = with pkgs; [
    fuzzel
    noctalia-shell
    thunar
    mako
    swaylock-effects
    swayidle
  ];

}
