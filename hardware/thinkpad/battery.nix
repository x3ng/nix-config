{ pkgs, ... }:

{
  # ThinkPad battery charge thresholds via tpacpi-bat
  # Configure with: sudo tpacpi-bat -s ST 0 80 && sudo tpacpi-bat -s SP 0 95
  environment.systemPackages = with pkgs; [ tpacpi-bat ];
}