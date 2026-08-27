{ pkgs, ... }:

{

  nix.settings.experimental-features = [
    "nix-command"
    "flakes"
  ];

  nixpkgs.config.allowUnfree = true;

  programs.nix-ld.enable = true;

  programs.command-not-found.enable = true;

  environment.systemPackages = with pkgs; [
    home-manager
  ];

  system.stateVersion = "26.05";

}
