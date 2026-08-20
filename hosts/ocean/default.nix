{ ... }:
{
  imports = [
    ../../disko/single-disk-ext4.nix
    ./hardware-configuration.nix

    ../../base/boot.nix
    ../../base/local.nix
    ../../base/nix.nix
    ../../base/users
    ../../base/users/xen.nix
    ../../software/networkmanager.nix
    ../../software/tailscale.nix
    ../../software/mihomo.nix
    ../../software/font.nix
    ../../software/fcitx5.nix
    ../../software/xremap.nix
    ../../software/cups.nix
    ../../software/docker.nix
    ../../software/podman.nix
    ../../software/libvirt.nix
    ../../software/flatpak.nix
    ../../software/kmscon.nix
    ../../software/cosmic.nix

    ../../hardware/firmware.nix
    ../../hardware/ssd.nix
    ../../hardware/audio.nix
    ../../hardware/bluetooth.nix
    ../../hardware/laptop.nix
    ../../hardware/cpu/intel/kaby-lake.nix
    ../../hardware/gpu/intel/kaby-lake.nix
  ];

  local.storage.disks = [
    "/dev/nvme0n1"
  ];

  networking.hostName = "ocean";
}
