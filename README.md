# nix-config

Flake-based NixOS and Home Manager software installation and runtime environment.

## Ownership boundary

**At present, both Nix and Home Manager install software and provide its runtime
environment; they do not take ownership of application configuration.**
Dotfiles, editable QML, application preferences and runtime state remain outside
this repository's deployment. Do not introduce configuration-file generation,
`home.file` / `xdg.configFile` ownership, checkout symlinks or automatic source
updates merely to install a package. Existing historical modules do not authorize
expanding that scope. See [AGENTS.md](AGENTS.md) for the mandatory working rules.

## Agent map

- `flake.nix` defines the NixOS and home-manager outputs.
- `hosts/*/default.nix` composes each host from modules.
- `system/` contains base OS settings; `hardware/` contains shared hardware services;
  `software/` contains optional system services and desktop modules.
- `disko/` owns disk layouts and filesystems; generated hardware scans live under
  `hosts/`.
- `hosts/ocean/hardware.nix` imports the upstream `nixos-hardware` T480 profile
  and holds local device overrides. Keep the generated `hardware-configuration.nix`
  separate; do not copy upstream defaults into local modules.
- `home/` contains home-manager modules and packages. `home/modules/` holds session
  policy (sandboxes, autostart, env) and packaging for third-party software that
  nixpkgs does not carry; `home/packages.nix` is the flat install list.
- Desktop preferences remain outside this repository; dotfiles is independently
  managed. Nullshell source lives in `~/.config/quickshell/nullshell`, independently of
  dotfiles. Quickshell loads that editable checkout; Nix installs its runtime.

## Working with this repository

```bash
nh os switch path:.
nh home switch path:.
```

Use `path:.` so local untracked files are visible to Nix. Use `-H` or `-c` to
choose a host or home configuration explicitly.

## Management boundaries

- NixOS owns system services, drivers, permissions and desktop integration.
- Home Manager currently installs user packages and provides necessary runtime
  environment only. Application configuration and session startup policy belong
  in independently managed dotfiles. Existing integration is historical, not
  permission to expand configuration ownership.
- Keep general CLI applications in `home/packages.nix`; hardware modules should
  install only driver support and hardware diagnostics. FFmpeg lives in Home
  Manager; the standard package already includes VAAPI support.
- Optional modules take effect only when imported. Keep explicit host imports
  rather than automatically loading every file in a directory.

`flake.lock` pins `nixos-hardware` alongside the other inputs. Update it separately
with `nix flake update nixos-hardware`, review changes, then check display,
suspend/resume and power behavior after reboot. The T480 profile currently sets
GuC=2, FBC=1 and PSR=2; local NVMe APST disabling remains a separate workaround.

## Nullshell runtime and session

The locked `nullshell` input supplies upstream Quickshell, our helper and runtime
dependencies. `software/hyprland.nix` installs the complete runtime and explicitly
configures PAM, Polkit, portal, optional GeoClue and greeter environment. Nullshell
is not installed or configured through Home Manager in this repository. Other
consumers may choose Home Manager to manage their configuration; that does not
change this repository's installation-only policy.

User QML is maintained independently. Hyprland dotfiles start `nullshell desktop`,
`nullshell locker`, `nullshell polkit` (each with `--no-duplicate`) and
`nullshell sleep-bridge`. The launchers use Quickshell's native configuration
names; installation never creates or updates the QML checkout. Greeter resources
are a separate system-owned snapshot and never load user HOME code.

The Settings portal publishes nullshell's effective appearance mode. Manual/auto
choices and coordinates belong to the application/user, not Nix. There is no
Darkman startup or parallel GSettings writer in this integration. Existing dconf
support remains for unrelated GTK applications.

After an accepted runtime update, build the OS output before `nh os switch path:.`.
Use a new login for changed session startup; do not replace active authentication
processes. QML preview iteration needs neither a flake update nor a switch.

### One-time cleanup of the previous installation

An older Home Manager generation installed a nullshell runtime that also shadows
`quickshell` in the user profile. Activate the updated Home Manager output once
to remove that obsolete package. The new Home Manager output contains no
nullshell package or module; subsequent nullshell updates require only the OS
installation. This cleanup is necessary even after the OS runtime is installed,
because the old user-profile commands otherwise take precedence in PATH.

Do the initial cutover from a TTY after logging out of the graphical session:
activate the new OS and the one-time Home Manager cleanup, switch the independent
QML checkout to the accepted `master`, and deploy the Hyprland dotfiles with
`~/.dotfiles/deploy/deploy hypr` (including native `hypridle.conf`), then log into
Hyprland. Nullshell retains its original development history with
a boundary-fix commit. The live checkout may still be detached to avoid hot reload;
inspect its status and preserve local changes before switching branches. No Nix
activation manages the QML checkout.

## Hardware scans and disks

Disko owns partitioning and the resulting `fileSystems`/`swapDevices` declarations.
Generate hardware scans with `--no-filesystems` so they only describe the boot
modules and detected hardware. Preview a fresh scan on the running host with:

```bash
nixos-generate-config --no-filesystems --show-hardware-config
```

Review the output before replacing `hosts/ocean/hardware-configuration.nix`.
Keep manual overrides in `hosts/ocean/hardware.nix`. During installation, add
`--root /mnt` to scan the mounted target. Hardware scans are needed after relevant
hardware changes, not on every rebuild. A normal system switch uses Disko's mount
declarations; partitioning/formatting is a separate, explicit Disko operation.
