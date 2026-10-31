{ pkgs, ... }:

{
  home.packages = with pkgs; [
    # Language runtimes and toolchains
    gcc
    zig
    go
    nodejs
    python3
    uv
    rustc
    cargo
    clippy
    rustfmt
    cargo-watch

    # Language servers and code intelligence
    tree-sitter
    gopls
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
    foot
    tmux
    zellij
    btop
    fastfetch

    vim
    neovim
    emacs-pgtk
    vscodium
    zed-editor

    # Desktop applications
    chromium

    # Common user tools, kept available when changing the desktop session.
    imv
    meld
    baobab
    catfish
    kdePackages.okular

    ffmpeg
    vlc
    gimp
    kdePackages.kdenlive
    inkscape
    obs-studio

    flameshot
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
    motrix
    rayburst
    proxychains-ng
    tigervnc
    filezilla
    rustdesk-flutter

    # System and device utilities
    lm_sensors
    pciutils
    usbutils
    android-tools

    # Archives and compression
    # tar + gzip/bzip2/xz/lzma/zstd and plain zip come from the system profile.
    # _7zz is the official 7-Zip CLI (ip7z/7zip); the -rar variant adds the
    # unrar-licensed decoder, which plain _7zz lacks for pre-RAR5 archives.
    # unrar stays for password-protected archives, where it is the reference.
    # Note: 7-Zip has no zstd codec, use the zstd(1) from the system for that.
    zip
    unzip
    _7zz-rar
    unrar
  ];
}
