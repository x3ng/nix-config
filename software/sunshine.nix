{ ... }:

{
  userGroups = [ "uinput" ];

  services.sunshine = {
    enable = true;
    autoStart = false;
    openFirewall = true;
  };
}
