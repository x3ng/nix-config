{
  config,
  pkgs,
  ...
}:

let
  userName = "xen";
in

{
  programs.zsh.enable = true;

  users.users.${userName} = {
    isNormalUser = true;
    description = userName;
    shell = pkgs.zsh;
    extraGroups = [ "wheel" ] ++ config.userGroups;
  };

  nix.settings.trusted-users = [ userName ];
}
