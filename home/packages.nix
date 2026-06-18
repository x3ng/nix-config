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
    lua-language-server
    marksman

    # cli
    tlrc
    ripgrep
    jq
    yq-go

    fd
    bat
    eza
    zoxide
    delta
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
    glow

    # editor
    vim
    neovim
    emacs-pgtk

    # terminal
    alacritty
    ghostty

    # browser
    chromium

    # media
    ffmpeg
    vlc
    gimp
    kdePackages.kdenlive
    inkscape
    obs-studio

    # utils
    rofi
    libreoffice-qt
    calibre
    vscode
    thunderbird
    rnote
    pandoc
    crow-translate
    cherry-studio
    flclash
    claude-code
    codex
    opencode
    aichat
    aider-chat
    fabric-ai

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
    typst
  ];
}
