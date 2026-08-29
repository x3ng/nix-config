{ pkgs, ... }:

let
  wpsPkg = pkgs.wpsoffice-cn;

  # Run WPS inside a bubblewrap sandbox. This is purely a *lifecycle* sandbox (not
  # a security boundary): its only job is to keep the background wpscloudsvr daemon
  # contained so it dies with the session (the namespace is torn down on exit, and
  # we also pkill it afterwards). Apart from that, WPS gets the whole filesystem
  # (--bind / /) and full /dev, so it behaves exactly like a normal app.
  #
  # Gotchas worked out while setting this up:
  #   - bwrap lays a minimal /dev AND a minimal /proc on top of --bind / /. Both must
  #    be re-bound AFTER --bind / /: --dev-bind /dev /dev and --proc /proc. If either
  #    comes first, --bind / / overlays the host /dev (read-only /dev/null) or host
  #    /proc (breaks WPS under --unshare-pid), and WPS fails to start. So the order
  #    is: --bind / /, then --tmpfs /tmp, then --dev-bind /dev /dev, then --proc /proc.
  #   - We use a fresh --tmpfs /tmp (not the host /tmp) so the WPS launcher script's
  #    internal `awk -F'='` OEM probe doesn't trip over stale files in the host /tmp
  #    (harmless warning otherwise), and so temp files don't leak across sessions.
  #  - bwrap's own --proc /proc (not the host /proc) is required; with the host
  #    /proc under --unshare-pid WPS fails to start.
  #  - The WPS launcher script calls awk/sed internally, but NixOS has no /bin, so
  #    we expose the system bins as /bin and set PATH=/bin for it.
  # Network is shared (license checks / cloud); swap --share-net for --unshare-net
  # to go fully offline.
  mkWrapper = app: pkgs.writeShellScript app ''
    XDG_RUNTIME_DIR="''${XDG_RUNTIME_DIR:-/run/user/$(id -u)}"
    ${pkgs.bubblewrap}/bin/bwrap \
      --unshare-all \
      --die-with-parent \
      --new-session \
      --share-net \
      --bind / / \
      --tmpfs /tmp \
      --dev-bind /dev /dev \
      --proc /proc \
      --ro-bind /run/current-system/sw/bin /bin \
      --setenv PATH /bin \
      ${wpsPkg}/bin/${app} "$@"
    ${pkgs.procps}/bin/pkill -x wpscloudsvr 2>/dev/null || true
  '';

  apps = [ "wps" "wpp" "et" "wpspdf" ];

  # Wrapper package exposing wps/wpp/et/wpspdf on PATH, plus the stock .desktop
  # files and icons copied from wpsoffice-cn. We install ONLY this (not
  # wpsoffice-cn directly — its bin/wps etc. must not shadow the wrappers), so
  # launcher entries (Exec=wps/wpp/…) resolve to the wrappers via PATH.
  wpsWrapped = pkgs.stdenvNoCC.mkDerivation {
    name = "wps-wrapped";
    phases = [ "installPhase" ];
    installPhase = ''
      mkdir -p $out/bin
      cp -r ${wpsPkg}/share $out/
      # Point .desktop Exec= lines at our sandboxed wrappers instead of the
      # raw wpsoffice-cn binaries, so launching from the app menu is sandboxed too.
      chmod -R u+w $out/share/applications
      for f in $out/share/applications/*.desktop; do
        [ -e "$f" ] || continue
        sed -i 's|${wpsPkg}/bin/|$out/bin/|g' "$f"
      done
    '' + builtins.concatStringsSep "\n" (
      map (app: "ln -s ${mkWrapper app} $out/bin/${app}") apps
    );
  };
in
{
  home.packages = [ wpsWrapped ];
}
