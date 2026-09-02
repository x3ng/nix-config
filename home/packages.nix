{ pkgs, ... }:

{
  home.packages = with pkgs; [
    tree-sitter
    gcc
    zig
    nodejs
    python3
    uv
    ctags
    rustc
    cargo
    clippy
    rustfmt
    cargo-watch
    racket

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
    nil
    nixfmt
    statix
    deadnix
    nh

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
