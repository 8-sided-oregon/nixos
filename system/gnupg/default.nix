{ pkgs, ... }: {
  programs.gnupg.agent = {
    enable = true;
    pinentryPackage = pkgs.pinentry-qt;
  };
  environment.systemPackages = [ pkgs.gnupg ];
}
