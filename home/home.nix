{ ... }:

{
  home.username = "xen";
  home.homeDirectory = "/home/xen";
  home.stateVersion = "26.05";

  home.sessionPath = [
    "$HOME/.local/bin"
  ];

  home.sessionVariables = {
    EDITOR = "nvim";
    VISUAL = "nvim";
  };

  imports = [
    ./packages.nix
    ./modules/bash.nix
    ./modules/starship.nix
    ./modules/fzf.nix
    ./modules/zoxide.nix
    ./modules/direnv.nix
    ./modules/firefox.nix
    ./modules/trash.nix
  ];
}
