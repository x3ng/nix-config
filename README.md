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
base/                      baseline NixOS configuration shared by normal hosts
software/                  optional NixOS modules layered on top of base
home/home.nix              home-manager entry point — imports packages + modules
home/packages.nix          user packages
```

### Base (`base/`)

Baseline NixOS configuration — boot, locale, Nix behavior, and user declarations.

| Path | Purpose |
| --- | --- |
| `boot.nix` | systemd-boot, latest kernel |
| `local.nix` | Timezone, locale |
| `nix.nix` | Flakes, unfree, nix-ld, home-manager CLI, stateVersion |
| `users/default.nix` | `userGroups` option for centralized group management |
| `users/xen.nix` | `xen` user account |

### Hardware (`hardware/`)

Physical device configuration — firmware, audio, bluetooth, CPU, GPU, power management.

| Path | Purpose |
| --- | --- |
| `firmware.nix` | linux-firmware, fwupd, redistributable firmware |
| `ssd.nix` | SSD TRIM (fstrim) |
| `audio.nix` | PipeWire |
| `bluetooth.nix` | Bluetooth (experimental, fast connectable) |
| `laptop.nix` | power-profiles-daemon, TrackPoint |
| `cpu/intel/kaby-lake.nix` | Microcode, thermald, throttled, kvm-intel |
| `gpu/intel/kaby-lake.nix` | i915 params, intel-media-driver, VA-API |

### Software (`software/`)

Optional system-level software configuration — desktop, services, networking backend, tools.

| Path | Purpose |
| --- | --- |
| `networkmanager.nix` | NetworkManager backend |
| `tailscale.nix` | Tailscale mesh networking |
| `mihomo.nix` | Proxy (mihomo TUN) + systemd-resolved DNS |
| `font.nix` | System fonts (Noto, Nerd Fonts, Chinese, emoji), fontconfig |
| `fcitx5.nix` | Chinese input method |
| `xremap.nix` | Key remapping (uinput) |
| `kmscon.nix` | TTY console (kmscon + Nerd Font) |
| `cups.nix` | Printing |
| `docker.nix` | Docker |
| `podman.nix` | Podman container runtime |
| `libvirt.nix` | KVM/QEMU virtual machines |
| `flatpak.nix` | Flatpak + Flathub |
| `cosmic.nix` | COSMIC desktop — current DE |

The active module list is the `imports` block in `hosts/<host>/default.nix`; this table is documentation, not the source of truth.

Backup modules (not imported, kept for experimentation): `lxqt.nix`, `hyprland.nix`, `niri.nix`, `plasma.nix`.

### Home-manager (`home/`)

| Path | Purpose |
| --- | --- |
| `home.nix` | Entry point — session variables, path, imports `packages.nix` and `modules/` |
| `packages.nix` | Direct install packages by category (dev, cli, editor, terminal, etc.) |
| `modules/` | Configurable app/feature modules imported by `home.nix` (bash, starship, fzf, zoxide, direnv, firefox, trash) |

Available hosts/users are listed in `flake.nix` outputs.

## Conventions

- Baseline NixOS config → `base/`, optional NixOS modules → `software/`, hardware config → `hardware/`, user environment → `home/`.
- `disko/` owns disk layouts and generated filesystem/swap configuration; host hardware scans are generated with `nixos-generate-config --no-filesystems`.
- `hosts/<host>/default.nix` chooses modules for that host and may contain small host-local settings such as hostname and disk devices.
- Reusable logic belongs in `base/`, `hardware/`, `software/`, or `home/`; host-local exceptions live under `hosts/<host>/`.
- `userGroups` option in `base/users/default.nix` lets software modules declare required groups (`userGroups = [ "docker" ]`) instead of hardcoding group lists.
- `allowUnfree = true` set in both `flake.nix` (home-manager) and `base/nix.nix` (NixOS).
