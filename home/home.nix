{ config, pkgs, ... }:

{
  home.username = "xen";
  home.homeDirectory = "/home/xen";

  home.sessionPath = [
    "$HOME/.local/bin"
  ];

  programs.bash = {
    enable = true;
    bashrcExtra = ''
      export EDITOR=nvim
      export VISUAL=nvim
    '';
  };

  programs.starship = {
    enable = true;
    enableBashIntegration = true;
  };

  imports = [
    ./packages.nix
    ./modules/xremap.nix
  ];

  home.stateVersion = "25.11";

}
