{ config, pkgs, ... }:

{

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

}
