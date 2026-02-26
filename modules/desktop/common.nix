{ config, pkgs, ... }:

{

  services.greetd = {
    enable = true;
    settings = {
      default_session = {
        command = ''
          ${pkgs.tuigreet}/bin/tuigreet \
            --time \
            --remember \
            --remember-user-session \
            --asterisks \
            --sessions ${config.services.xserver.displayManager.sessionData.desktops}/share/wayland-sessions \
            --xsessions ${config.services.xserver.displayManager.sessionData.desktops}/share/xsessions
        '';
        
        user = "greeter";
      };
    };
  };
  
}
