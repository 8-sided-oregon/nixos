{ config, pkgs, lib, hostnameCfg, ... }: {
  imports = [ 
    (hostnameCfg ./. "")
    ./programs/firefox
    ./programs/hyfetch
    ./programs/hyprland
    ./programs/kitty
    ./programs/neovim
    ./programs/rofi
    ./programs/waybar
    ./programs/zsh
    ./programs/git
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
    fastfetch
    vlc
    mpv
    strawberry
    okular
    feh
    git
    keepassxc
    pass
    age
    imagemagick
    bat
    exiftool
    dunst
    hyprpaper
    hypridle
    brightnessctl
    yt-dlp
    libreoffice
    kdePackages.neochat
    discordo
    # TODO: properly fix this
    (signal-desktop.overrideAttrs (final: prev: {
      postFixup = ''
        # Wayland-ify the .desktop file
        substituteInPlace $out/share/applications/${final.pname}.desktop \
          --replace-fail "Exec=$out/bin/${final.pname}" "Exec=$out/bin/${final.pname} --enable-features=UseOzonePlatform --ozone-platform=wayland"
      '';
    }))
    xfce.thunar-bare
    # for qt6 to work with wayland display scaling properly 
    qt6.qtwayland
    # thumbnail stuff
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
