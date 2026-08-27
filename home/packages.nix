{ pkgs, ... }:

{
  home.packages = with pkgs; [
    tree-sitter
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
    nil
    nixfmt
    statix
    deadnix
    nh

    chafa
    glow
    television

    alacritty
    wezterm
    kitty
    ghostty
    rio
    tmux
    zellij
    btop
    fastfetch

    vim
    neovim
    emacs-pgtk
    zed-editor

    chromium

    ffmpeg
    vlc
    gimp
    kdePackages.kdenlive
    inkscape
    obs-studio

    anyrun
    flameshot
    thunar
    libreoffice-qt
    thunderbird
    rnote
    zathura

    pandoc
    typst
    texliveFull

    nmap
    aria2
    proxychains-ng
    clash-verge-rev
    tigervnc
    filezilla
    rustdesk-flutter
    localsend

    lm_sensors
    pciutils
    usbutils
    zip
    unzip
    android-tools
    wl-clipboard
  ];
}
