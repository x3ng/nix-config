{ config, pkgs, lib, ... }:

{

  options.userGroups = lib.mkOption {
    type = lib.types.listOf lib.types.str;
    default = [];
    description = "User groups required by enabled services, merged automatically";
  };

  config = {
    users.users.xen = {
      isNormalUser = true;
      description = "xen";
      extraGroups = [ "networkmanager" "wheel" ] ++ config.userGroups;
    };
  };

}
