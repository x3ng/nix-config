# eDiary is a purpose-built diary app that nixpkgs does not carry, so this
# repackages the upstream Debian package instead of building from source.
#
# There is no session policy here: no sandbox, no autostart, nothing to
# configure. It is packaging only, because the upstream .deb is more or less an
# AppImage relative to a normal Debian install.
#
# Two things the packaging has to get right:
#   - The binary is a Lazarus/FireMonkey app that links against glibc only and
#     dlopen()s GTK3 at runtime. Without LD_LIBRARY_PATH it dies with
#     "GTK 3 is required to be installed".
#   - The resource tree and the bundled OpenSSL 1.0.0 are resolved relative to
#     the executable, so the binary and its resources must stay siblings instead
#     of being split into $out/share.
#
# Gotcha: eDiary writes its data to $HOME/Documents/eDiary, not to an XDG
# directory. That path is hardcoded upstream and cannot be redirected.
#
# Note: take `pkgs` rather than individual package sets. home-manager only
# passes pkgs/lib/config/options to modules; naming e.g. stdenvNoCC directly
# makes the module system fall back to _module.args, which needs `config` and
# therefore deadlocks during module collection.
{
  pkgs,
  ...
}:

let
  inherit (pkgs)
    atk
    cairo
    dpkg
    gdk-pixbuf
    glib
    gtk3
    icu
    lib
    libGL
    libX11
    libxfixes
    makeWrapper
    pango
    stdenvNoCC
    vlc
    zlib
    ;

  # The upstream .desktop hardcodes Exec=/opt/ediary/ediary, so regenerate it.
  # This also fixes an invalid Version=1.0-beta2 (the spec wants 1.5).
  desktopFile = pkgs.makeDesktopItem {
    name = "ediary";
    desktopName = "eDiary";
    exec = "ediary";
    icon = "ediary";
    comment = "Time-based life archive for diary entries, work logs and notes";
    categories = [
      "Office"
      "Utility"
      "TextEditor"
    ];
  };

  gtkStack = [
    gtk3
    glib
    pango
    cairo
    gdk-pixbuf
    atk
    libX11
    libxfixes
    libGL
    icu
    vlc
    zlib
  ];

  ediary = stdenvNoCC.mkDerivation {
    pname = "ediary";
    version = "1.0~beta2-2";

    src = pkgs.fetchurl {
      url = "https://down.haoxg.net/download/ediary/linux/ediary_1.0~beta2-2_amd64.deb";
      hash = "sha256-Sv68Rl24nUNimtRHCYhJPMyBjRI56W6zF6a18EAo6Aw=";
    };

    nativeBuildInputs = [
      dpkg
      makeWrapper
    ];

    dontConfigure = true;
    dontBuild = true;

    installPhase = ''
      runHook preInstall

      dpkg-deb -x $src ediary-root

      mkdir -p $out/libexec/ediary
      cp -r ediary-root/opt/ediary/. $out/libexec/ediary/

      # The bundled OpenSSL libraries use versioned SONAMEs but ship without
      # the corresponding filenames.
      ln -s libcrypto.so $out/libexec/ediary/resources/ssl/libcrypto.so.1.0.0
      ln -s libssl.so $out/libexec/ediary/resources/ssl/libssl.so.1.0.0

      makeWrapper $out/libexec/ediary/ediary $out/bin/ediary \
        --prefix LD_LIBRARY_PATH : ${lib.makeLibraryPath gtkStack}:"$out/libexec/ediary/resources/ssl"

      install -Dm644 ediary-root/usr/share/icons/hicolor/256x256/apps/ediary.png \
        $out/share/icons/hicolor/256x256/apps/ediary.png
      install -Dm644 ${desktopFile}/share/applications/ediary.desktop \
        $out/share/applications/ediary.desktop

      runHook postInstall
    '';

    meta = {
      description = "Time-based life archive: diary, work log and document manager";
      homepage = "https://www.haoxg.net/";
      # Closed source and free to use; upstream publishes no license text.
      license = lib.licenses.unfree;
      sourceProvenance = [ lib.sourceTypes.binaryNativeCode ];
      platforms = [ "x86_64-linux" ];
      mainProgram = "ediary";
    };
  };
in

{
  home.packages = [ ediary ];
}
