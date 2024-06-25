{ pkgs, ... }:
{
  environment.systemPackages = [ pkgs.nfs-utils ];
  # TODO: Setup server and client configs (ooo maybe over yggdrasil???)
}
