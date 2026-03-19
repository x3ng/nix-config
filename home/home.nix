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

  home.packages = with pkgs;[
    gcc
    clang-tools
    python3
    uv
    pyright
    racket
    ghc
    cabal-install
    ormolu
    haskell-language-server

    ripgrep
    jq
    yq-go
    fzf
    tmux
    zellij

    lm_sensors
    pciutils
    usbutils
    git
    gnumake
    cmake
    fastfetch
    tree
    gnused
    gnutar
    gawk
    wl-clipboard
    wget
    yazi
    proxychains-ng
    nmap
    mihomo
    texlive.combined.scheme-full
    android-tools

    vim
    neovim
    emacs-pgtk

    alacritty
    kitty
    ghostty

    vlc
    tigervnc
    filezilla
    gimp
    aria2
    chromium
    nyxt
    qutebrowser
    libreoffice
    vscode
    thunderbird
    xournalpp
    inkscape
    calibre
    cherry-studio
    clash-verge-rev
  ];

  imports = [
    ./modules/xremap/xremap.nix
  ];

  xremap = {
    enable = true;
  };

  home.stateVersion = "25.11";

}
