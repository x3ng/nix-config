{ config, pkgs, lib, ... }:

{
  imports = [
      ./hardware-configuration.nix
      ./system.nix
      ./packages.nix
      ./desktop.nix
    ];

  # Allow unfree packages
  nixpkgs.config.allowUnfree = true;

  # Experimental features
  nix.settings.experimental-features = [ "nix-command" "flakes" ];

  system.stateVersion = "25.11";
}
