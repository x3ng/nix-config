{ config, pkgs, ... }:

{
  fonts.packages = with pkgs; [
    noto-fonts
    noto-fonts-cjk-sans
    noto-fonts-cjk-serif
    noto-fonts-color-emoji
    dejavu_fonts
    unifont

    nerd-fonts.jetbrains-mono
    nerd-fonts.space-mono
    maple-mono.variable
    hack-font
    source-code-pro
    sarasa-gothic

    wqy_microhei
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
        "Noto Sans"
        "WenQuanYi Micro Hei"
        "DejaVu Sans"
      ];
      serif = [
        "Noto Serif CJK SC"
        "Noto Serif"
        "DejaVu Serif"
      ];
      monospace = [
        "JetBrainsMono Nerd Font"
        "Maple Mono VF"
        "Sarasa Mono SC"
        "Source Code Pro"
        "DejaVu Sans Mono"
        "Space Mono"
        "Hack"
        "Unifont"
      ];
      emoji = [ "Noto Color Emoji" ];
    };
  };
}
