{ config, pkgs, ... }:

{

  virtualisation.libvirtd = {
    enable = true;
  };
  programs.virt-manager.enable = true;

  boot.extraModprobeConfig = ''
    options kvm-intel nested=1 enable_apicv=1 ept=1
  '';

  environment.systemPackages = with pkgs; [
    # virt-manager, libvirt, qemu are pulled in by the options above
    virt-viewer
    libguestfs
  ];

  networking.firewall.trustedInterfaces = [ "virbr0" ];

  userGroups = [ "libvirtd" "kvm" "qemu" ];

}
