{ ... }:
{
  imports = [
    ../../disko/single-disk-ext4.nix
    ./hardware-configuration.nix

    # system — OS platform layer (required on every host)
    ../../system/boot.nix
    ../../system/locale.nix
    ../../system/nix.nix
    ../../system/fonts.nix
    ../../system/users
    ../../system/users/xen.nix

    # software — optional modules, pick per host
    ../../software/networkmanager.nix
    ../../software/firewall.nix
    ../../software/tailscale.nix
    ../../software/mihomo.nix
    ../../software/fcitx5.nix
    ../../software/xremap.nix
    ../../software/kmscon.nix
    ../../software/cups.nix
    ../../software/docker.nix
    ../../software/podman.nix
    ../../software/libvirt.nix
    ../../software/flatpak.nix
    ../../software/cosmic.nix

    # hardware — physical devices
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
