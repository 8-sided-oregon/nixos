{ config, pkgs, lib, hostnameCfg, ... }:
let
  programs = [
    "firefox"
    "hyfetch"
    "hyprland"
    "kitty"
    "neovim"
    "rofi"
    "waybar"
    "zsh"
    "git"
  ];
  program2import = name: [ (lib.path.append ./programs "${name}.nix") (hostnameCfg ./programs name) ];
  programImports = lib.lists.flatten (map program2import programs);
in
{
  #
  imports = programImports ++
    [ 
      (hostnameCfg ./. "")
    ];

  home.username = "ava";
  home.homeDirectory = "/home/ava";

  home.stateVersion = "24.05";

  home.packages = with pkgs; [
    (nerdfonts.override { 
        fonts = 
          [ 
            "Ubuntu" 
            "UbuntuMono" 
            "AnonymousPro" 
            "NerdFontsSymbolsOnly"
          ]; 
      })
    hyfetch
    vlc
    mpv
    strawberry
    okular
    feh
    git
    keepassxc
    imagemagick
    bat
    exiftool
    dunst
    hyprpaper
    hypridle
    brightnessctl
    yt-dlp
    kdePackages.neochat
    # for qt6 to work with wayland display scaling properly 
    qt6.qtwayland
    # for dolphin to be able to create thumbnails and icons
    #kdePackages.kdegraphics-thumbnailers
    #kdePackages.ffmpegthumbs
    #kdePackages.qt6ct
    #kdePackages.breeze
    #kdePackages.breeze-gtk
    #kdePackages.breeze-icons
    xfce.thunar-bare
    xfce.tumbler
    ffmpegthumbnailer
  ];

  home.sessionVariables = {
    EDITOR = "nvim";
    BROWSER = "firefox";
    #QT_QPA_PLATFORMTHEME = "qt6ct";
  };

  programs.home-manager.enable = true;

  xdg.userDirs = 
  let
    f = _: rel: "${config.home.homeDirectory}/${rel}";
  in 
  lib.mapAttrs f {
    desktop = "xdg/Desktop";
    download = "dls";
    templates = "xdg/Templates";
    publicShare = "xdg/Public";
    documents = "docs";
    music = "music";
    pictures = "media/images";
    videos = "media/videos";
  };
}
