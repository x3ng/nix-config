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

### System modules (`modules/`)

Each directory = one concern. Directories with `default.nix` are imported wholesale; individual `.nix` files imported by path in `hosts/<host>/default.nix`.

| Path | Purpose |
|---|---|
| `boot/` | systemd-boot, latest kernel |
| `core/` | Timezone, locale, redistributable firmware |
| `nix/` | Flakes, unfree, nix-ld, home-manager CLI, stateVersion |
| `user/` | User with `userGroups` option for centralized group management |
| `font/` | System fonts (Noto, Nerd Fonts, Chinese, emoji), fontconfig |
| `hardware/` | Intel graphics, PipeWire audio, Bluetooth, firmware/thermald/ppd/fstrim |
| `network/` | NetworkManager, dae/mihomo proxy (systemd + tun mode) |
| `software/` | SDDM, KDE Plasma 6, Hyprland, Niri, CUPS, Flatpak, fcitx5, xremap, Docker, libvirt |

### Home-manager (`home/`)

| Path | Purpose |
|---|---|
| `home.nix` | Entry point — session variables, path, imports `packages.nix` and `modules/` |
| `packages.nix` | Direct install packages by category (dev, cli, editor, terminal, etc.) |
| `modules/` | Configurable app/feature modules imported by `home.nix` (bash, firefox, fzf, starship, trash) |

Available hosts/users are listed in `flake.nix` outputs.

## Conventions

- System config → `modules/`, user config → `home/`.
- `hosts/<host>/default.nix` is a pure import list — no inline config.
- `software/` is the catch-all for non-universal software-level system config.
- `userGroups` option in `modules/user/` lets software modules declare required groups (`userGroups = [ "docker" ]`) instead of hardcoding group lists.
- KDE and Hyprland coexist; share SDDM.
- `allowUnfree = true` set in both `flake.nix` (home-manager) and `modules/nix/` (NixOS).
