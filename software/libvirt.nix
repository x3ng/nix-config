{ config, pkgs, ... }:

{

  virtualisation.libvirtd = {
    enable = true;
    qemu = {
      package = pkgs.qemu_kvm;
      swtpm.enable = true;
      vhostUserPackages = [ pkgs.virtiofsd ];
    };
    nss.enableGuest = true;
  };
  programs.virt-manager.enable = true;
  virtualisation.spiceUSBRedirection.enable = true;

  boot.extraModprobeConfig = ''
    options kvm-intel nested=1 enable_apicv=1 ept=1
  '';

  environment.systemPackages = with pkgs; [
    # virt-manager, libvirt, qemu are pulled in by the options above
    virt-viewer
    libguestfs
    guestfs-tools
    virt-top
    virtio-win
    win-spice
    freerdp
  ];

  networking.firewall.trustedInterfaces = [ "virbr0" ];

  userGroups = [ "libvirtd" "kvm" "qemu" ];

}
