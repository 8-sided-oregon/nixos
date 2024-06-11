{
  programs.zsh = {
    enable = true;
    enableCompletion = true;
    autosuggestion.enable = true;
    syntaxHighlighting.enable = true;
    shellAliases = {
      ll = "ls -hla";
    };
    oh-my-zsh.enable = true;
    oh-my-zsh.theme = "half-life";
  };
}
