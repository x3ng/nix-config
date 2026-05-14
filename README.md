# nix-config

NixOS flake configuration for a single host with home-manager.

## Usage

```bash
# Apply system config
sudo nixos-rebuild switch --flake .#ocean

# Apply home-manager config
home-manager switch --flake .#xen

# Build without applying
nixos-rebuild build --flake .#ocean

# Update flake inputs
nix flake update
```

## Module Structure

| Path | Purpose |
|---|---|
| `boot/` | systemd-boot, latest kernel |
| `core/` | Timezone, locale, firmware |
| `nix/` | Nix settings, nix-ld, home-manager CLI |
| `user/` | User definition with centralized group management |
| `font/` | System fonts and fontconfig |
| `hardware/` | Graphics, audio, Bluetooth, firmware/thermald |
| `network/` | NetworkManager, proxy services (dae, mihomo) |
| `software/` | SDDM, KDE Plasma 6, Hyprland, Niri, CUPS, Flatpak, fcitx5, xremap, Docker, libvirt |

## Home Manager

| Path | Purpose |
|---|---|
| `home.nix` | Shell, starship, firefox, imports |
| `packages.nix` | User packages |
| `modules/xremap.nix` | xremap user service |
