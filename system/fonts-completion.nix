{
  lib,
  stdenv,
  fetchFromGitHub,
}:

let
  # Chinese fonts: SimSun, SimHei, KaiTi, FangSong, Microsoft YaHei, etc.
  chineseFonts = fetchFromGitHub {
    owner = "jiaxiaochu";
    repo = "font";
    rev = "613a015764a97901c4de077b71e1d60f17254e87";
    sha256 = "sha256-TbkfnjGazEciR1KxdtSHtKFTTbcQ3uXy9dFMSu1G+BQ=";
  };

  # Latin fonts (Arial, Calibri, Consolas, etc.) + symbol fonts (Wingding, Symbol, etc.)
  latinAndSymbolFonts = fetchFromGitHub {
    owner = "BannedPatriot";
    repo = "ttf-wps-fonts";
    rev = "8c980c24289cb08e03f72915970ce1bd6767e45a";
    sha256 = "sha256-x+grMnpEGLkrGVud0XXE8Wh6KT5DoqE6OHR+TS6TagI=";
  };
in
stdenv.mkDerivation {
  pname = "fonts-completion";
  version = "unstable-2024";

  dontUnpack = true;

  installPhase = ''
    runHook preInstall

    local font_dir=$out/share/fonts/truetype
    install -d $font_dir

    # Install Latin + symbol fonts
    find ${latinAndSymbolFonts} -type f \( -iname "*.ttf" -o -iname "*.ttc" -o -iname "*.otf" \) \
      -exec install -Dm644 -t $font_dir {} +

    # Install Chinese fonts (skip duplicates)
    find ${chineseFonts} -maxdepth 1 -type f \( -iname "*.ttf" -o -iname "*.ttc" -o -iname "*.otf" \) -print0 | while IFS= read -r -d $'\0' font_file; do
      font_basename=$(basename "$font_file")
      if [ ! -f "$font_dir/$font_basename" ]; then
        install -Dm644 "$font_file" "$font_dir/$font_basename"
      fi
    done

    runHook postInstall
  '';

  meta = with lib; {
    description = "WPS Office compatibility fonts (Chinese + Latin + symbols)";
    license = licenses.unfree;
    platforms = platforms.all;
  };
}
