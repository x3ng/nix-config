{
  config,
  pkgs,
  ...
}:

let
  userName = "xen";
in

{
  users.users.${userName} = {
    isNormalUser = true;
    description = userName;
    shell = pkgs.bashInteractive;
    extraGroups = [ "wheel" ] ++ config.userGroups;
  };

  nix.settings.trusted-users = [ userName ];
}
