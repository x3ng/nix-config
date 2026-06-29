{ config, pkgs, lib, ... }:
{
  imports = [
    ./hardware-configuration.nix

    ../../base/boot.nix
    ../../base/local.nix
    ../../base/nix.nix
    ../../base/users
    ../../base/users/xen.nix
    ../../software/networkmanager.nix
    ../../software/mihomo.nix
    ../../software/font.nix
    ../../software/fcitx5.nix
    ../../software/xremap.nix
    ../../software/cups.nix
    ../../software/docker.nix
    ../../software/libvirt.nix
    ../../software/flatpak.nix
    ../../software/kmscon.nix
    ../../software/plasma.nix

    ../../hardware/firmware.nix
    ../../hardware/ssd.nix
    ../../hardware/audio.nix
    ../../hardware/bluetooth.nix
    ../../hardware/laptop.nix
    ../../hardware/cpu/intel/kaby-lake.nix
    ../../hardware/gpu/intel/kaby-lake.nix
  ];

  networking.hostName = "ocean";
}
