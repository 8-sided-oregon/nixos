{ pkgs, ... }:
{
  environment.systemPackages = [ pkgs.steamcmd ];
  programs.steam.enable = true;
}
