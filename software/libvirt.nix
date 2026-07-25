{ config, pkgs, ... }:

{

  virtualisation.libvirtd = {
    enable = true;
    qemu = {
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
    virt-viewer
    virt-top
    win-spice
    freerdp
  ];

  networking.firewall.trustedInterfaces = [ "virbr0" ];

  userGroups = [ "libvirtd" "kvm" "qemu" ];

}
