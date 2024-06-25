{ pkgs, ... }:
{
  programs.zsh.enable = true;
  users.users.ava = {
    isNormalUser = true;
    description = "Ava Pagefault";
    extraGroups = [ "networkmanager" "wheel" ];
    shell = pkgs.zsh;
  };
}
