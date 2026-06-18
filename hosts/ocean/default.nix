{ config, pkgs, lib, ... }:
{
  imports = [
    ./hardware-configuration.nix

    ../../software/boot.nix
    ../../software/core.nix
    ../../software/nix.nix
    ../../software/user.nix
    ../../software/xen.nix
    ../../software/network.nix
    ../../software/mihomo.nix
    ../../software/font.nix
    ../../software/fcitx5.nix
    ../../software/xremap.nix
    ../../software/cups.nix
    ../../software/docker.nix
    ../../software/libvirt.nix
    ../../software/flatpak.nix
    ../../software/plasma.nix

    ../../hardware/firmware.nix
    ../../hardware/audio.nix
    ../../hardware/bluetooth.nix
    ../../hardware/laptop.nix
    ../../hardware/cpu/intel/kaby-lake.nix
    ../../hardware/gpu/intel/kaby-lake.nix
  ];

}
