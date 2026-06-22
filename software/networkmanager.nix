{ config, pkgs, ... }:

{
  networking.networkmanager = {
    enable = true;
  };

  userGroups = [ "networkmanager" ];
}
