{ pkgs, ... }:

{
  # Enabling Steam also sets hardware.graphics.enable32Bit, installs the
  # steam-hardware udev rules and enables 32-bit ALSA/PipeWire support.
  # Client preferences, the library and Proton prefixes live under
  # ~/.local/share/Steam and stay user-managed.
  programs.steam = {
    enable = true;

    # Inbound Remote Play hosting: TCP 27036/27037, UDP 10400/10401 and
    # 27031-27035, plus UDP 27036 peer discovery. Not needed for playing.
    remotePlay.openFirewall = true;

    # Ships GE-Proton's compatibilitytool.vdf; select it per game in Steam.
    extraCompatPackages = [ pkgs.proton-ge-bin ];

    # MangoHud ships its own 32-bit layer; visible inside Steam's FHS
    # container so games can be started with `mangohud %command%`.
    extraPackages = [ pkgs.mangohud ];

    # Winetricks wrapper for Proton prefixes.
    protontricks.enable = true;
  };

  # Used on demand by `gamemoderun %command%`: niceness and screensaver inhibit.
  programs.gamemode.enable = true;
}
