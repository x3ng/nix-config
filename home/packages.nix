{ pkgs, ... }:

{
  home.packages = with pkgs; [
    gcc
    nodejs
    python3
    uv
    pyright
    clang-tools
    ctags
    rustc
    cargo
    clippy
    rustfmt
    rust-analyzer
    cargo-watch
    racket
    ghc
    cabal-install
    ormolu
    haskell-language-server
    lua-language-server
    marksman
    verible

    git
    gnumake
    cmake
    ripgrep
    fd
    bat
    eza
    jq
    yq-go
    delta
    nvd
    wget
    tree
    gnused
    gnutar
    gawk
    subversion

    yazi
    chafa
    glow
    television

    alacritty
    ghostty
    tmux
    zellij
    btop
    fastfetch

    vim
    neovim
    emacs-pgtk
    zed-editor

    chromium
    qutebrowser

    ffmpeg
    vlc
    gimp
    kdePackages.kdenlive
    inkscape
    obs-studio

    rofi
    flameshot
    thunar
    libreoffice-qt
    vscode
    thunderbird
    rnote
    zathura

    pandoc
    typst
    texliveFull

    pi-coding-agent
    opencode
    claude-code
    codex

    nmap
    aria2
    proxychains-ng
    clash-verge-rev
    tigervnc
    filezilla
    rustdesk-flutter

    lm_sensors
    pciutils
    usbutils
    zip
    unzip
    android-tools
    wl-clipboard
  ];
}
