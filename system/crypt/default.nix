{ pkgs, ... }:
{
  environment.systemPackages = with pkgs; [
    gocryptfs
    age
  ];
}
