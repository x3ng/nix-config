{ config, pkgs, ... }:

{
  home.username = "xen";
  home.homeDirectory = "/home/xen";

  programs.firefox.enable = true;

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
    ./modules/trash.nix
  ];

  home.stateVersion = "26.05";

}
