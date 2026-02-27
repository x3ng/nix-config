{ config, pkgs, ... }:

{
  fonts.packages = with pkgs; [
    noto-fonts
    noto-fonts-cjk-sans
    noto-fonts-cjk-serif
    noto-fonts-color-emoji
    dejavu_fonts
    unifont

    (nerd-fonts.jetbrains-mono)
    maple-mono.variable
    hack-font
    source-code-pro
    sarasa-gothic

    lxgw-wenkai

    font-awesome
    material-design-icons
  ];

  fonts.fontconfig = {
    enable = true;

    antialias = true;
    subpixel = {
      rgba = "rgb";
      lcdfilter = "default";
    };

    hinting = {
      enable = true;
      style = "slight";
    };

    defaultFonts = {
      sansSerif = [
        "Noto Sans CJK SC"
        "LXGW WenKai"
        "Noto Sans"
        "DejaVu Sans"
      ];
      serif = [
        "Noto Serif CJK SC"
        "LXGW WenKai"
        "Noto Serif"
        "DejaVu Serif"
      ];
      monospace = [
        "JetBrainsMono Nerd Font"
        "Maple Mono VF"
        "Sarasa Gothic SC"
        "Hack"
        "Unifont"
      ];
      emoji = [ "Noto Color Emoji" ];
    };
  };
}
