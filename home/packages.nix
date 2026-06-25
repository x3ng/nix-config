{ pkgs, ... }:

{
  home.packages = with pkgs; [
    # dev
    gcc
    clang-tools
    python3
    rustc
    cargo
    clippy
    rustfmt
    rust-analyzer
    cargo-watch
    uv
    pyright
    racket
    ghc
    cabal-install
    ormolu
    haskell-language-server
    lua-language-server
    marksman
    verible

    # cli
    tlrc
    ripgrep
    jq
    yq-go

    fd
    bat
    eza

    delta
    tmux
    zellij
    btop
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
    helix
    neovim
    emacs
    zed-editor

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
    flameshot
    zathura
    thunar
    libreoffice-qt
    calibre
    vscode
    thunderbird
    rnote
    pandoc
    crow-translate
    cherry-studio
    clash-verge-rev
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
