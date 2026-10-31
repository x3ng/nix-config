# nix-config

Flake-based NixOS and home-manager configuration.

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
- Desktop settings and Quickshell files may be symlinked from `/home/xen/.dotfiles`,
  outside this repository. Check both places when investigating desktop behavior.

## Working with this repository

```bash
nh os switch path:.
nh home switch path:.
```

Use `path:.` so local untracked files are visible to Nix. Use `-H` or `-c` to
choose a host or home configuration explicitly.

## Management boundaries

- NixOS owns system services, drivers, permissions and desktop integration.
- Home Manager owns user packages and necessary session integration. Application
  preferences, profiles, documents and other mutable state stay in user space or
  dotfiles; do not turn them into Nix-managed state.
- Keep general CLI applications in `home/packages.nix`; hardware modules should
  install only driver support and hardware diagnostics. FFmpeg lives in Home
  Manager; the standard package already includes VAAPI support.
- Optional modules take effect only when imported. Keep explicit host imports
  rather than automatically loading every file in a directory.

`flake.lock` pins `nixos-hardware` alongside the other inputs. Update it separately
with `nix flake update nixos-hardware`, review changes, then check display,
suspend/resume and power behavior after reboot. The T480 profile currently sets
GuC=2, FBC=1 and PSR=2; local NVMe APST disabling remains a separate workaround.

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
