{ config, pkgs, ... }:

{

  virtualisation.docker.enable = true;

  users.users.xen.extraGroups = [ "docker" ];

}
