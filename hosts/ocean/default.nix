{ ... }:
{
  imports = [
    ../../disko/single-disk-ext4.nix
    ./hardware-configuration.nix

    ../../base/boot.nix
    ../../base/local.nix
    ../../base/nix.nix
    ../../base/firewall.nix
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
    ../../hardware/audio.nix
    ../../hardware/bluetooth.nix
    ../../hardware/cpu/kaby-lake.nix
    ../../hardware/gpu/kaby-lake.nix
    ../../hardware/input/trackpoint.nix
    ../../hardware/thinkpad/battery.nix
    ../../hardware/power/ppd.nix
    ../../hardware/storage/nvme.nix
    ../../hardware/storage/fstrim.nix
  ];

  local.storage.disks = [
    "/dev/nvme0n1"
  ];

  networking.hostName = "ocean";
}
