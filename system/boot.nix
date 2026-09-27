{ pkgs, ... }:

{

  boot = {
    loader = {
      efi.canTouchEfiVariables = true;
      grub = {
        enable = true;
        efiSupport = true;
        device = "nodev";
      };
    };

    kernelPackages = pkgs.linuxPackages_latest;
  };

}
