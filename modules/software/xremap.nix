# System prerequisites for xremap (user service configured in home-manager)
{ config, pkgs, ... }:

{

  boot.kernelModules = [ "uinput" ];

  services.udev.extraRules = ''
    KERNEL=="uinput", MODE="0660", GROUP="input", OPTIONS+="static_node=uinput"
    SUBSYSTEM=="hidraw", MODE="0660", GROUP="input"
  '';

  userGroups = [ "input" ];

}
