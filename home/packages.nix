{ pkgs, ... }:

{
  home.packages = with pkgs; [
    # dev
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

    # cli
    ripgrep
    jq
    yq-go
    fzf
    tmux
    zellij
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
    chafa
    viu

    # editor
    vim
    neovim
    emacs-pgtk

    # terminal
    alacritty
    kitty
    ghostty

    # browser
    chromium
    nyxt
    qutebrowser

    # media
    ffmpeg
    vlc
    gimp
    kdePackages.kdenlive
    inkscape

    # utils
    libreoffice
    calibre
    vscode
    thunderbird
    xournalpp
    drawio
    pandoc
    crow-translate
    cherry-studio
    clash-verge-rev
    claude-code

    # js
    nodejs

    # system
    lm_sensors
    pciutils
    usbutils
    zip
    unzip
    proxychains-ng
    nmap
    aria2
    android-tools
    tigervnc
    filezilla
    rustdesk-flutter
    texlive.combined.scheme-full
  ];
}
