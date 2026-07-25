{ config, pkgs, ... }:

{
  services.caffeine = {
    enable = true;
    package = pkgs.caffeine-ng;
  };
}
