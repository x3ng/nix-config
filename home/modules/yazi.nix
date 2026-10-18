{ pkgs, ... }:

{
  programs.yazi = {
    enable = true;
    enableBashIntegration = true;
    enableZshIntegration = true;
    shellWrapperName = "y";

    # Keep settings, keymaps and init.lua in ~/.dotfiles/yazi.
    # Use the RAR-capable 7-Zip for Yazi's built-in archive support too.
    package = pkgs.yazi.override { _7zz = pkgs._7zz-rar; };
    extraPackages = with pkgs; [
      git
      glow
      xdg-utils
      mediainfo
      exiftool
    ];

    # Pin plugin versions through flake.lock; no separate `ya pkg upgrade`.
    plugins = with pkgs.yaziPlugins; {
      inherit
        git
        piper
        toggle-pane
        chmod
        ;
    };
  };
}
