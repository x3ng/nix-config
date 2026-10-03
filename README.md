# nix-config

Flake-based NixOS and home-manager configuration.

## Agent map

- `flake.nix` defines the NixOS and home-manager outputs.
- `hosts/*/default.nix` composes each host from modules.
- `system/` contains base OS settings; `hardware/` contains device-specific settings;
  `software/` contains optional system services and desktop modules.
- `disko/` owns disk layouts and filesystems; generated hardware scans live under
  `hosts/`.
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
