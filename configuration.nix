{ config, pkgs, hostname, hostnameCfg, ... }:
{
  imports =
    [
      (hostnameCfg ./. "-hw-config")
      (hostnameCfg ./. "-config")
    ];

  nix.settings.experimental-features = [ "nix-command" "flakes" ];

  boot.loader.systemd-boot.enable = true;
  boot.loader.efi.canTouchEfiVariables = true;

  networking.hostName = hostname;
  networking.networkmanager.enable = true;

  time.timeZone = "America/New_York";

  i18n.defaultLocale = "en_US.UTF-8";
  i18n.extraLocaleSettings = {
    LC_ADDRESS = "en_US.UTF-8";
    LC_IDENTIFICATION = "en_US.UTF-8";
    LC_MEASUREMENT = "en_US.UTF-8";
    LC_MONETARY = "en_US.UTF-8";
    LC_NAME = "en_US.UTF-8";
    LC_NUMERIC = "en_US.UTF-8";
    LC_PAPER = "en_US.UTF-8";
    LC_TELEPHONE = "en_US.UTF-8";
    LC_TIME = "en_US.UTF-8";
  };

  services.printing.enable = true;

  programs.git.enable = true;
  programs.git.config.init.defaultBranch = "main";

  hardware.pulseaudio.enable = false;
  security.rtkit.enable = true;
  services.pipewire = {
    enable = true;
    alsa.enable = true;
    alsa.support32Bit = true;
    pulse.enable = true;
  };

  users.users.ava = {
    isNormalUser = true;
    description = "Ava Pagefault";
    extraGroups = [ "networkmanager" "wheel" ];
    packages = with pkgs; [
      kate
    ];
    shell = pkgs.zsh;
  };

  programs.zsh.enable = true;
  programs.hyprland.enable = true;

  nixpkgs.config.allowUnfree = true;

  environment.systemPackages = with pkgs; [
    aria2
    vim
    grim
    slurp
    wl-clipboard
    mako
    kitty
    fortune
    dolphin
    htop
    btop
    usbtop
    iftop
    powertop
    fd
    pavucontrol
    nfs-utils
    python3
    psmisc
  ];

  services.gnome.gnome-keyring.enable = true;

  services.upower.enable = true;
  services.tlp.enable = true;
  services.logind.lidSwitch = "suspend";
  services.logind.lidSwitchExternalPower = "suspend";
  services.logind.lidSwitchDocked = "suspend";

  # NEVER CHANGE (obv)
  system.stateVersion = "24.05";
}
