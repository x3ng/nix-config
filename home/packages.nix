{ pkgs, ... }:

{
  home.packages = with pkgs; [
    # Language runtimes and toolchains
    gcc
    zig
    nodejs
    python3
    uv
    rustc
    cargo
    clippy
    rustfmt
    cargo-watch
    racket

    # Language servers and code intelligence
    tree-sitter
    ctags
    nil
    typescript-language-server
    vscode-langservers-extracted
    yaml-language-server
    ty
    taplo
    rust-analyzer
    clang-tools
    bash-language-server
    marksman
    lua-language-server
    verible

    # Development and command-line tools
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
    gnused
    gnutar
    gawk
    subversion
    nixfmt
    statix
    deadnix
    nh

    # Terminal applications and editors
    chafa
    glow
    television

    kitty
    tmux
    zellij
    btop
    fastfetch

    vim
    helix
    neovim
    emacs-pgtk
    zed-editor

    # Desktop applications
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

    # Documents and publishing
    pandoc
    typst
    texliveFull

    # Networking and remote access
    nmap
    aria2
    proxychains-ng
    clash-verge-rev
    tigervnc
    filezilla
    rustdesk-flutter
    localsend

    # System and device utilities
    lm_sensors
    pciutils
    usbutils
    zip
    unzip
    android-tools
    wl-clipboard
  ];
}
