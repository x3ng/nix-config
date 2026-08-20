_:

{
  networking.networkmanager = {
    enable = true;
  };

  userGroups = [ "networkmanager" ];
}
