{ pkgs, ... }:

{
  fonts.packages = [ pkgs.nerd-fonts.jetbrains-mono ];

  services.kmscon = {
    enable = true;
    useXkbConfig = true;
    config = {
      font-name = "JetBrainsMonoNL Nerd Font Mono";
    };
  };
}
