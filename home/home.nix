{ ... }:

{
  home = {
    username = "xen";
    homeDirectory = "/home/xen";
    stateVersion = "26.05";

    sessionPath = [
      "$HOME/.local/bin"
    ];

    sessionVariables = {
      EDITOR = "nvim";
      VISUAL = "nvim";
    };
  };

  imports = [
    ./packages.nix
    ./modules/bash.nix
    ./modules/starship.nix
    ./modules/fzf.nix
    ./modules/yazi.nix
    ./modules/zoxide.nix
    ./modules/direnv.nix
    ./modules/firefox.nix
    ./modules/trash.nix
  ];
}
