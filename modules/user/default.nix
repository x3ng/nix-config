{ config, pkgs, ... }:

{

  users.users.xen = {
    isNormalUser = true;
    description = "xen";
    extraGroups = [ "networkmanager" "wheel" ];
  };

}
