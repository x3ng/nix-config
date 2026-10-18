{ pkgs, ... }:

{

  boot = {
    loader = {
      efi.canTouchEfiVariables = true;
      grub = {
        enable = true;
        efiSupport = true;
        device = "nodev";

        # Optional appearance config is deployed independently by dotfiles.
        # Keep NixOS in charge of boot entries; missing dotfiles use the normal menu.
        theme = null;
        splashImage = null;
        extraConfig = ''
          if [ -f "$prefix/custom.cfg" ]; then
            source "$prefix/custom.cfg"
          fi
        '';
      };
    };

    kernelPackages = pkgs.linuxPackages_latest;
  };

}
