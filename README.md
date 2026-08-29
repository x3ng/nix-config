# nix-config

Flake-based NixOS + home-manager configuration (x86_64-linux).

Currently one host (`ocean`) and one user (`xen`).

## Usage

```bash
sudo nixos-rebuild switch --flake path:.#<host>
home-manager switch --flake path:.#<user>
nix flake update
```

Always use `path:.` prefix — avoids needing `git add` before build.

`nh` is available in the user profile as a lower-friction frontend:

```bash
nh os switch path:.
nh home switch path:.
```

Use `-H <host>` or `-c <user>` only when selecting a non-default NixOS host or home-manager configuration.

## Structure

```
flake.nix                  inputs, outputs (nixosConfigurations + homeConfigurations)
hosts/<host>/default.nix   host assembly — imports shared modules plus small host-local settings
hosts/<host>/hardware-configuration.nix
                           host hardware scan, generated with --no-filesystems
disko/                     declarative disk layouts — filesystems, mountpoints, swap
system/                    OS platform layer — boot, locale, nix, fonts, users (every host needs it)
software/                  optional NixOS modules layered on top of system
hardware/                  physical device configuration
home/home.nix              home-manager entry point — imports packages + modules
home/packages.nix          user packages
```

### System (`system/`)

OS platform layer — the foundation every host needs regardless of hardware or desktop.

| Path | Purpose |
| --- | --- |
| `boot.nix` | systemd-boot, latest kernel |
| `locale.nix` | Timezone, locale |
| `nix.nix` | Flakes, unfree, nix-ld, home-manager CLI, stateVersion |
| `fonts.nix` | System fonts + fontconfig (Latin-first ordering; see file comments) |
| `users/default.nix` | `userGroups` option for centralized group management |
| `users/xen.nix` | `xen` user account |

### Software (`software/`)

Optional NixOS modules layered on top of `system/`. Placement rule: if a fresh host
needs it to function as a base OS, it belongs in `system/`; otherwise `software/`.

| Path | Purpose |
| --- | --- |
| `networkmanager.nix` | NetworkManager backend |
| `firewall.nix` | Firewall enable |
| `tailscale.nix` | Tailscale mesh networking |
| `mihomo.nix` | Proxy (mihomo TUN) + systemd-resolved DNS |
| `fcitx5.nix` | Chinese input method |
| `xremap.nix` | Key remapping (uinput) |
| `kmscon.nix` | TTY console (kmscon + pinned Nerd Font) |
| `cups.nix` | Printing |
| `docker.nix` | Docker |
| `podman.nix` | Podman container runtime |
| `libvirt.nix` | KVM/QEMU virtual machines |
| `flatpak.nix` | Flatpak + Flathub |
| `cosmic.nix` | COSMIC desktop — current DE |

The active module list is the `imports` block in `hosts/<host>/default.nix`; this table is documentation, not the source of truth.

Backup modules (not imported, kept for experimentation): `lxqt.nix`, `hyprland.nix`, `niri.nix`, `plasma.nix`.

### Hardware (`hardware/`)

Physical device configuration — swap these out per machine.

| Path | Purpose |
| --- | --- |
| `firmware.nix` | linux-firmware, fwupd, redistributable firmware |
| `audio.nix` | PipeWire |
| `bluetooth.nix` | Bluetooth (experimental, fast connectable) |
| `cpu/kaby-lake.nix` | Microcode, thermald, throttled, kvm-intel |
| `gpu/kaby-lake.nix` | i915 modesetting driver, intel-media-driver, VA-API |
| `input/trackpoint.nix` | TrackPoint + wheel emulation |
| `power/ppd.nix` | power-profiles-daemon (DE-integrated power profiles; TLP is mutually exclusive with it) |
| `storage/fstrim.nix` | SSD TRIM timer |
| `storage/nvme.nix` | NVMe APST workaround |
| `thinkpad/battery.nix` | Battery charge thresholds via tpacpi-bat |

### Home-manager (`home/`)

| Path | Purpose |
| --- | --- |
| `home.nix` | Entry point — session variables, path, imports `packages.nix` and `modules/` |
| `packages.nix` | Direct install packages by category (dev, cli, editor, terminal, etc.) |
| `modules/` | Configurable app/feature modules imported by `home.nix` (bash, starship, fzf, zoxide, direnv, firefox, trash, wps) |

Available hosts/users are listed in `flake.nix` outputs.

## Conventions

- Modules are grouped by the biggest difference, kept coarse on purpose: OS platform → `system/`, everything optional → `software/`, physical devices → `hardware/`, user environment → `home/`. Avoid adding new top-level buckets unless a whole class of modules genuinely fits nowhere.
- `disko/` owns disk layouts and generated filesystem/swap configuration; host hardware scans are generated with `nixos-generate-config --no-filesystems`.
- `hosts/<host>/default.nix` chooses modules for that host and may contain small host-local settings such as hostname and disk devices.
- `userGroups` option in `system/users/default.nix` lets modules declare required groups (`userGroups = [ "docker" ]`) instead of hardcoding group lists.
- `allowUnfree = true` set in both `flake.nix` (home-manager) and `system/nix.nix` (NixOS).
- Fonts: Latin fonts precede CJK in every defaultFonts chain; LXGW WenKai is installed but never listed as fallback (see `system/fonts.nix`).
