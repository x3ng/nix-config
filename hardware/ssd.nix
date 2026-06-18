{ config, pkgs, ... }:

{
  # SSD maintenance
  services.fstrim.enable = true;
}
