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

## Structure

```
flake.nix                  inputs, outputs (nixosConfigurations + homeConfigurations)
hosts/<host>/default.nix   host entry point — pure import list, no inline config
home/home.nix              home-manager entry point — shell, starship, firefox, imports
home/packages.nix          user packages
```

### Hardware (`hardware/`)

Physical device configuration — firmware, audio, bluetooth, CPU, GPU, power management.

| Path | Purpose |
|---|---|
| `firmware.nix` | linux-firmware, fwupd, redistributable firmware |
| `ssd.nix` | SSD TRIM (fstrim) |
| `audio.nix` | PipeWire |
| `bluetooth.nix` | Bluetooth (experimental, fast connectable) |
| `laptop.nix` | power-profiles-daemon, TrackPoint |
| `cpu/intel/kaby-lake.nix` | Microcode, thermald, throttled, kvm-intel |
| `gpu/intel/kaby-lake.nix` | i915 params, intel-media-driver, VA-API |

### Software (`software/`)

System-level software configuration — desktop, services, networking, tools.

| Path | Purpose |
|---|---|
| `boot.nix` | systemd-boot, latest kernel |
| `local.nix` | Timezone, locale |
| `nix.nix` | Flakes, unfree, nix-ld, home-manager CLI, stateVersion |
| `user.nix` | `userGroups` option for centralized group management |
| `xen.nix` | User account |
| `network.nix` | Hostname, NetworkManager |
| `mihomo.nix` | Proxy (mihomo TUN) + systemd-resolved DNS |
| `font.nix` | System fonts (Noto, Nerd Fonts, Chinese, emoji), fontconfig |
| `fcitx5.nix` | Chinese input method |
| `xremap.nix` | Key remapping (uinput) |
| `cups.nix` | Printing |
| `docker.nix` | Docker |
| `libvirt.nix` | KVM/QEMU virtual machines |
| `flatpak.nix` | Flatpak + Flathub |
| `plasma.nix` | KDE Plasma 6 + X11 |

Backup modules (not imported, kept for experimentation): `cosmic.nix`, `lxqt.nix`, `hyprland.nix`, `niri.nix`, `sddm.nix`.

### Home-manager (`home/`)

| Path | Purpose |
|---|---|
| `home.nix` | Entry point — session variables, path, imports `packages.nix` and `modules/` |
| `packages.nix` | Direct install packages by category (dev, cli, editor, terminal, etc.) |
| `modules/` | Configurable app/feature modules imported by `home.nix` (bash, firefox, fzf, starship, trash) |

Available hosts/users are listed in `flake.nix` outputs.

## Conventions

- Hardware config → `hardware/`, software config → `software/`, user config → `home/`.
- `hosts/<host>/default.nix` is a pure import list — no inline config.
- `userGroups` option in `software/user.nix` lets software modules declare required groups (`userGroups = [ "docker" ]`) instead of hardcoding group lists.
- `allowUnfree = true` set in both `flake.nix` (home-manager) and `software/nix.nix` (NixOS).
