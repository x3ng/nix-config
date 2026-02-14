{ config, pkgs, ... }:

{
  # boot
  boot.loader.systemd-boot.enable = true;
  boot.loader.efi.canTouchEfiVariables = true;

  boot.kernelPackages = pkgs.linuxPackages_latest;

  time.timeZone = "Asia/Shanghai";

  i18n = {
    defaultLocale = "en_US.UTF-8";
  };

  # graphic driver
  hardware.graphics = {
    enable = true;
    extraPackages = with pkgs; [ intel-media-driver ];
  };

  services.xserver.videoDrivers = [ "modesetting" ];

  environment.systemPackages = with pkgs; [
    libva
    libva-utils
    ffmpeg-full
  ];

  environment.sessionVariables = {
    LIBVA_DRIVER_NAME = "iHD";
  };

  hardware.enableRedistributableFirmware = true;
  boot.kernelParams = [ "i915.enable_guc=3" ];

  # network
  networking.hostName = "ocean";

  services.smartdns = {
    enable = true;
    settings = {
      bind = "127.0.0.1:53";
      server = [
        "119.29.29.29"
        "223.5.5.5"
        "114.114.114.114"
        "8.8.8.8"
        "1.1.1.1"
      ];
      speed-check-mode = "ping,tcp:80,tcp:443";
      cache-size = 8192;
    };
  };

  networking.networkmanager = {
    enable = true;
    dns = "none";
  };

  networking.nameservers = [ "127.0.0.1" ];

  # fonts
  fonts.packages = with pkgs; [
    adwaita-fonts
    noto-fonts
    noto-fonts-cjk-sans
    noto-fonts-cjk-serif
    noto-fonts-color-emoji
    unifont
    dejavu_fonts

    jetbrains-mono
    maple-mono.variable
    hack-font
    source-code-pro
    sarasa-gothic

    nerd-fonts.symbols-only
    font-awesome
    material-design-icons
  ];

  fonts.fontconfig = {
    enable = true;
    defaultFonts = {
      sansSerif = [ "Noto Sans CJK SC" "Noto Sans" "DejaVu Sans" ];
      serif = [ "Noto Serif CJK SC" "Noto Serif" "DejaVu Serif" ];
      monospace = [ "JetBrains Mono" "Maple Mono" "Sarasa Gothic SC" "Hack" ];
      emoji = [ "Noto Color Emoji" ];
    };
  };

  # user
  users.users.xen = {
    isNormalUser = true;
    description = "xen";
    extraGroups = [ "networkmanager" "wheel" "input" ];
  };

  boot.kernelModules = [ "uinput" ];

  services.udev.extraRules = ''
    KERNEL=="uinput", MODE="0660", GROUP="input", OPTIONS+="static_node=uinput"
  '';

  # input
  i18n.inputMethod.enable = true;
  i18n.inputMethod.type = "fcitx5";
  i18n.inputMethod.fcitx5.addons = with pkgs; [
    qt6Packages.fcitx5-chinese-addons
  ];

  environment.sessionVariables = {
    GTK_IM_MODULE = "fcitx";
    QT_IM_MODULE = "fcitx";
    XMODIFIERS = "@im=fcitx";
  };

  # audio
  services.pulseaudio.enable = false;
  security.rtkit.enable = true;
  services.pipewire = {
    enable = true;
    alsa.enable = true;
    alsa.support32Bit = true;
    pulse.enable = true;
  };

  # display
  services.xserver.enable = true;
  services.xserver.xkb = {
    layout = "us";
    variant = "";
  };

  # printing
  services.printing.enable = true;

}
