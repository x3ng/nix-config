{ pkgs, ... }:

{
  home.packages = with pkgs; [
    # dev
    ctags
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
    subversion
    television

    # editor
    vim
    neovim
    emacs-pgtk
    zed-editor

    # terminal
    alacritty
    ghostty

    # browser
    chromium
    qutebrowser

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
    vscode
    thunderbird
    rnote
    pandoc
    clash-verge-rev
    pi-coding-agent
    opencode
    claude-code
    codex

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
    texliveFull
    typst
  ];
}
