{ pkgs, ... }:

{
  fonts.packages = [ pkgs.nerd-fonts.iosevka-term ];

  services.kmscon = {
    enable = true;
    useXkbConfig = true;
    config = {
      font-name = "IosevkaTerm Nerd Font Mono";
    };
  };
}
