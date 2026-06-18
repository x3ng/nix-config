{ config, pkgs, lib, ... }:

let
  userName = "xen";
in

{
  users.users.${userName} = {
    isNormalUser = true;
    description = userName;
    extraGroups = [ "networkmanager" "wheel" ] ++ config.userGroups;
  };

  nix.settings.trusted-users = [ userName ];
}
