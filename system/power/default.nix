{ pkgs, ... }:
{
  environment.systemPackages = with pkgs; [
    powertop
    usbtop
  ];

  services.upower.enable = true;
  services.tlp.enable = true;
}
