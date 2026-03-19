{ config, pkgs, ... }:

{

  users.users.xen = {
    isNormalUser = true;
    description = "xen";
    extraGroups = [ "networkmanager" "wheel" "input" ];
  };

  boot.kernelModules = [ "uinput" ];

  services.udev.extraRules = ''
    KERNEL=="uinput", MODE="0660", GROUP="input", OPTIONS+="static_node=uinput"
    SUBSYSTEM=="hidraw", MODE="0660", GROUP="input"
  '';

}
