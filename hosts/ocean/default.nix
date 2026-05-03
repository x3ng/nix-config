{ config, pkgs, lib, ... }:
{
  imports = [
    ./hardware-configuration.nix
    ../../modules/boot
    ../../modules/core
    ../../modules/user
    ../../modules/network
    ../../modules/network/mihomo.nix
    ../../modules/font
    ../../modules/services/fcitx5.nix
    ../../modules/services/xremap.nix
    ../../modules/services/cups.nix
    ../../modules/services/docker.nix
    ../../modules/services/libvirt.nix
    ../../modules/hardware/firmware.nix
    ../../modules/hardware/audio.nix
    ../../modules/hardware/graphic.nix
    ../../modules/hardware/bluetooth.nix
    ../../modules/desktop/sddm.nix
    ../../modules/desktop/kde.nix
    ../../modules/desktop/hyprland.nix
    ../../modules/packages/system.nix
    ../../modules/packages/flatpak.nix
  ];

  programs.nix-ld.enable = true;
  nixpkgs.config.allowUnfree = true;
  nix.settings.experimental-features = [ "nix-command" "flakes" ];
  system.stateVersion = "25.11";
}
