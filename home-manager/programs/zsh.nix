{ config, pkgs, ... }:
{
  programs.zsh = {
    enable = true;
    enableCompletion = true;
    autosuggestion.enable = true;
    syntaxHighlighting.enable = true;
    shellAliases = {
      ll = "ls -hla";
      trueVim = "${pkgs.vim}/bin/vim";
      sysrebuild = "sudo nixos-rebuild switch --flake '${config.home.homeDirectory}/nixfiles/config'";
    };
    envExtra = ''
     function ndev() { 
       nix develop $@ --command zsh
     }
    '';
    oh-my-zsh.enable = true;
    oh-my-zsh.theme = "half-life";
  };
}
