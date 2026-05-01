{ config, pkgs, ... }:

{

  virtualisation.libvirtd = {
    enable = true;
  };
  programs.virt-manager.enable = true;

  boot = {
    kernelModules = [ "kvm-intel" ];
    extraModprobeConfig = ''
      options kvm-intel nested=1 enable_apicv=1 ept=1
    '';
  };

  environment.systemPackages = with pkgs; [
    libvirt
    qemu
    virt-manager
    virt-viewer
    dnsmasq
    bridge-utils
    libguestfs
  ];

  networking.firewall.trustedInterfaces = [ "virbr0" ];

  users.users.xen.extraGroups = [ "libvirtd" "kvm" "qemu" ];

}
