{
  config,
  ...
}:

let
  userName = "xen";
in

{
  users.users.${userName} = {
    isNormalUser = true;
    description = userName;
    extraGroups = [ "wheel" ] ++ config.userGroups;
  };

  nix.settings.trusted-users = [ userName ];
}
