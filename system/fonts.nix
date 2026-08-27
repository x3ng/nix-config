# System-wide fonts and fontconfig.
{ pkgs, ... }:

{
  fonts.packages = with pkgs; [
    inter
    noto-fonts
    noto-fonts-cjk-sans
    noto-fonts-cjk-serif
    noto-fonts-color-emoji
    corefonts
    vista-fonts

    nerd-fonts.iosevka-term
    jetbrains-mono
    source-code-pro
    monaspace
    maple-mono.variable
    maple-mono.NF-CN
    sarasa-gothic
    unifont
    lxgw-wenkai

    font-awesome
    material-design-icons
  ];

  fonts.fontconfig = {
    enable = true;

    antialias = true;
    subpixel.rgba = "rgb";

    hinting = {
      enable = true;
      style = "slight";
    };

    defaultFonts = {
      sansSerif = [
        "Noto Sans"
        "Noto Sans CJK SC"
      ];
      serif = [
        "Noto Serif"
        "Noto Serif CJK SC"
      ];
      monospace = [
        "IosevkaTerm Nerd Font Mono"
        "Maple Mono NF CN"
        "Sarasa Mono SC"
        "Monaspace Neon"
        "Monaspace Argon"
        "JetBrains Mono"
        "Source Code Pro"
        "Unifont"
      ];
      emoji = [ "Noto Color Emoji" ];
    };
  };
}
