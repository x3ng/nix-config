{ pkgs, ... }:

{
  # Shared storage services; keep these independent of desktop and application choices.
  # UDisks provides device discovery and authorised mounting for desktop clients.
  services.udisks2.enable = true;
  # USB device permissions for MTP clients (for example, Android file transfer).
  services.udev.packages = [ pkgs.libmtp.out ];
  # User-space mounts, including AppImage, portals, GVfs and tools such as sshfs.
  programs.fuse.enable = true;
}
