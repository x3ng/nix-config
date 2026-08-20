_:

{
  services = {
    xserver = {
      enable = true;
      xkb = {
        layout = "us";
        variant = "";
      };
    };

    desktopManager.plasma6.enable = true;
    displayManager.plasma-login-manager.enable = true;
  };
}
