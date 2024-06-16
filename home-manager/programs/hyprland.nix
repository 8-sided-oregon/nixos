{ config, lib, ... }:
let
  lock_cmd = "swaylock";
in
{
  options.hyprland.resolution = lib.mkOption {
    type = lib.types.str;
    description = "Main screen resolution";
  };

  options.hyprland.scale = lib.mkOption {
    type = lib.types.str;
    description = "Main screen scale factor";
    default = "1";
  };

  config = {
    # when you do `home-manager switch`, you have to manually reload the 
    # hyprland config with `hyprctl reload`, because home-manager does not
    # directly write to ~/.config/hypr/hyprland.conf, it just places a symlink.
    wayland.windowManager.hyprland.enable = true;
    wayland.windowManager.hyprland.settings = {
      input.mouse_refocus = false;
      #cursor.no_warps = true;
      monitor = 
        [
          "eDP-1, ${config.hyprland.resolution}, 0x0, ${config.hyprland.scale}"
          ", preferred, auto-left, 1"
        ];
      workspace = 
        [
          "10, monitor:HDMI-A-1, default:true" 
        ];
      general = {
        gaps_in = 3;
        gaps_out = 5;
        border_size = 1;
        "col.active_border" = "rgb(fe036a) rgb(f5347f) 45deg";
        "col.inactive_border" = "rgb(8a0030)";
      };
      master = {
        new_is_master = true;
      };
      decoration = {
        rounding = 10;
        active_opacity = 1.0;
        inactive_opacity = 1.0;
        drop_shadow = true;
        blur = {
            enabled = true;
            size = 4;
            passes = 2;
            vibrancy = 0.1696;
        };
      };
      animations.enabled = false;
      # binds
      "$mod" = "SUPER";
      exec-once = [ "hyprpaper" "hypridle" "dunst" ];
      exec = "pkill waybar; waybar";
      bind =
        [
          "$mod SHIFT, F, exec, firefox"
          "$mod,  RETURN, exec, kitty"
          "$mod, E, exec, dolphin"
          ''$mod, D, exec, rofi -show drun & sleep 0.2; hyprctl dispatch focuswindow "^(Rofi)"''
          "$mod SHIFT, Q, killactive"
          "$mod SHIFT, E, exit"
          "$mod, f, togglefloating,"
          "$mod, v, fullscreen, 0"
          "$mod, m, exec, ${lock_cmd}"
          "$mod, P, pseudo,"
          "$mod, S, togglesplit,"
          "$mod, Tab, cyclenext,"
          "$mod, Tab, bringactivetotop,"
          "$mod, h, movefocus, l"
          "$mod, l, movefocus, r"
          "$mod, k, movefocus, u"
          "$mod, j, movefocus, d"
        ]
        ++ (
          # workspaces
          # binds $mod + [shift +] {1..10} to [move to] workspace {1..10}
          builtins.concatLists (builtins.genList (
              x: let
                ws = let
                  c = (x + 1) / 10;
                in
                  builtins.toString (x + 1 - (c * 10));
              in [
                "$mod, ${ws}, workspace, ${toString (x + 1)}"
                "$mod SHIFT, ${ws}, movetoworkspace, ${toString (x + 1)}"
              ]
            )
            10)
        );
      bindm = 
        [
          "$mod, mouse:272, movewindow"
          "$mod, mouse:273, resizewindow"
        ];
      bindl =
        [
          ", XF86AudioMute, exec, wpctl set-mute @DEFAULT_AUDIO_SINK@ toggle"
          ", XF86AudioRaiseVolume, exec, wpctl set-volume @DEFAULT_AUDIO_SINK@ 5%+"
          ", XF86AudioLowerVolume, exec, wpctl set-volume @DEFAULT_AUDIO_SINK@ 5%-"
          ", XF86MonBrightnessUp, exec, brightnessctl set 10%+"
          ", XF86MonBrightnessDown, exec, brightnessctl set 10%-"
        ];
      windowrule = 
        [
          "opacity 1.0 override 0.9 overide 0.9,^(kitty)$"
        ];
    };

    services.hyprpaper.enable = true;
    services.hyprpaper.settings = {
      ipc = "on";
      splash = false;
      splash_offset = 2.0;
      preload =
        [ "/home/ava/media/images/wallpapers/sax.png" ];
      wallpaper = 
        [ "eDP-1,/home/ava/media/images/wallpapers/sax.png" ];
    };

    services.hypridle.enable = true;
    services.hypridle.settings = {
      general = {
        after_sleep_cmd = "hyprctl dispatch dpms on";
        ignore_dbus_inhibit = false;
        inherit lock_cmd;
      };
      listener = 
        [
          {
            timeout = 300;
            on-timeout = lock_cmd;
          }
          {
            timeout = 360;
            on-timeout = "hyprctl dispatch dpms off";
            on-resume = "hyprctl dispatch dpms on";
          }
          {
            timeout = 375;
            on-timeout = 
              "[ $(cat /sys/class/power_supply/AC/online) -eq 0 ] && systemctl suspend";
          }
        ];
    };

    programs.swaylock.enable = true;
    programs.swaylock.settings.image = "${config.home.homeDirectory}/media/images/wallpapers/jerma985.png";

    home.file."media/images/wallpapers".source = ../wallpapers;
  };
}
