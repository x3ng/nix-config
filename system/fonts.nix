# System-wide fonts and fontconfig.
#
# Principles:
# - Latin-first ordering: real Latin fonts render ASCII; CJK fonts only kick
#   in for CJK glyphs (CJK-embedded Latin has wide spacing/odd metrics).
# - Second slot in every chain is a full-coverage Noto CJK font, so glyph
#   fallback is intercepted before reaching deep-fallback scans. This keeps
#   LXGW WenKai (kaiti style) from ever being picked implicitly.
#
# kmscon note: fontconfig settings here are global (pango reads /etc/fonts),
# so they DO affect kmscon's glyph fallback. Its primary font stays pinned
# via software/kmscon.nix `font-name`, which is the actual isolation lever.
{ pkgs, ... }:

{
  fonts.packages = with pkgs; [
    noto-fonts
    noto-fonts-cjk-sans
    noto-fonts-cjk-serif
    noto-fonts-color-emoji
    corefonts

    nerd-fonts.jetbrains-mono
    maple-mono.variable
    sarasa-gothic
    unifont # explicit: defaultFonts floor below must not depend on enableDefaultPackages

    # Installed but deliberately absent from defaultFonts below: usable when
    # explicitly requested by name, never as an implicit fallback.
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
        "JetBrainsMono Nerd Font"
        "Maple Mono"
        "Sarasa Mono SC" # terminal CJK with exact halfwidth alignment
        "Unifont" # last-resort readability floor
      ];
      emoji = [ "Noto Color Emoji" ];
    };
  };
}
