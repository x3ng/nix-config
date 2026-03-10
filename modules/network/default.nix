{ config, pkgs, ... }:

{

  networking.hostName = "ocean";

  networking.networkmanager = {
    enable = true;
  };

}
