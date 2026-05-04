{ config, pkgs, lib, ... }:
{
  imports = [
    ./hardware-configuration.nix
    ../../modules/boot
    ../../modules/core
    ../../modules/nix
    ../../modules/user
    ../../modules/network
    ../../modules/network/mihomo.nix
    ../../modules/font
    ../../modules/software/fcitx5.nix
    ../../modules/software/xremap.nix
    ../../modules/software/cups.nix
    ../../modules/software/docker.nix
    ../../modules/software/libvirt.nix
    ../../modules/software/flatpak.nix
    ../../modules/hardware/firmware.nix
    ../../modules/hardware/audio.nix
    ../../modules/hardware/graphic.nix
    ../../modules/hardware/bluetooth.nix
    ../../modules/desktop/sddm.nix
    ../../modules/desktop/kde.nix
    ../../modules/desktop/hyprland.nix
  ];

}
