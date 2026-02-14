{ config, pkgs, lib, ... }:

{
  imports = [
      ./hardware-configuration.nix
      ./system.nix
      ./packages.nix
      ./modules/desktop/common.nix
      ./modules/desktop/kde.nix
      ./modules/desktop/hyprland.nix
      ./modules/virtulisation/libvirt.nix
      ./modules/virtulisation/docker.nix
    ];

  # Allow unfree packages
  nixpkgs.config.allowUnfree = true;

  # Experimental features
  nix.settings.experimental-features = [ "nix-command" "flakes" ];

  system.stateVersion = "25.11";
}
