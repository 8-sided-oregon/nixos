{ config, lib, ... }:
{
  options.waybar.mainbattery = lib.mkOption {
    type = lib.types.str;
    description = "Battery for waybar to display";
    default = "BAT0";
  };

  config = {
    programs.waybar = {
      enable = true;
      style = ''
        * {
            border: none;
            border-radius: 0;
            font-family: "Ubuntu Nerd Font";
            font-size: 13px;
            min-height: 0;
        }
        
        window#waybar {
            background: transparent;
            color: white;
        }
        
        #window {
            font-weight: bold;
            font-family: "Ubuntu";
        }
        /*
        #workspaces {
            padding: 0 5px;
        }
        */
        
        #workspaces button {
            padding: 0 5px;
            background: transparent;
            color: white;
            border-top: 2px solid transparent;
        }
        
        #workspaces button.active {
            color: #ff4dff;
            border-top: 2px solid #ff4dff;
        }
        
        #mode {
            background: #64727D;
            border-bottom: 3px solid white;
        }
  
        #clock, #battery, #cpu, #memory, #network, #idle_inhibitor, #backlight, #wireplumber, #tray, #mode {
            padding: 0 5px;
            margin: 0 2px;
        }
  
        
        #clock {
            font-weight: bold;
        }
        
        #battery {
            color: #66ff66;
            border-top: 2px solid #66ff66;
        }
  
        #battery.warning {
            color: #ffff66;
            border-top: 2px solid #ffff66;
        }
  
        #battery.critical {
            color: #ff3333;
            border-top: 2px solid #ff3333;
        }
        
        #battery icon {
            color: red;
        }
        
        #battery.charging {
        }
        
        #cpu {
        }
        
        #memory {
        }
        
        #network {
        }
        
        #network.disconnected {
            /*background: #f53c3c;*/
            color: #ff3333;
            border-top: 2px solid #ff3333;
        }
  
        #backlight {
        }
        
        #wireplumber {
        }
  
        #wireplumber.muted {
            color: #ff3333;
            border-top: 2px solid #ff3333;
        }
  
        #idle_inhibitor.activated {
            color: #ff3333;
            border-top: 2px solid #ff3333;
        }
        
        #tray {
        }
      '';
    };
  
    home.file.".config/waybar/config.jsonc".text = ''
      {
          "layer": "top",
          "position": "top",
          "height": 24,
          "modules-left": ["hyprland/workspaces"],
          "modules-center": ["hyprland/window"],
          "modules-right": ["wireplumber", "backlight", "idle_inhibitor", "network", "cpu", "memory", "battery", "tray", "clock"],
          "hyprland/workspaces": {
              "disable-scroll": true,
              "all-outputs": false,
              "format": "{name} {icon}",
              "format-window-seperator": " ",
              "format-icons": {
                  "1": " web",
                  "2": " code",
                  "3": " term",
                  "4": " docs",
                  "5": "󱉟 book",
                  "8": "󰑱 comms",
                  "9": " music",
                  "10": "󰍹 monitor",
                  "urgent": "",
                  "focused": "",
                  "default": ""
              }
          },
          "hyprland/window": {
              "format": "({title})",
              "separate-outputs": true
          },
          "idle_inhibitor": {
              "format": "{icon}",
              "format-icons": {
                  "activated": "",
                  "deactivated": ""
              }
          },
          "tray": {
              // "icon-size": 21,
              "spacing": 10
          },
          "clock": {
              "format-alt": "{:%Y-%m-%d}"
          },
          "cpu": {
              "format": "{usage}% "
          },
          "memory": {
              "format": "{}% "
          },
          "battery": {
              "bat": "${config.waybar.mainbattery}",
              "states": {
                  "warning": 30,
                  "critical": 15
              },
              "format": "{capacity}% {icon}",
              "format-icons": ["", "", "", "", ""]
          },
          "network": {
              "format-wifi": "{essid} ({signalStrength}%) ",
              "format-ethernet": "{ifname}: {ipaddr}/{cidr} ",
              "format-disconnected": "Disconnected ⚠"
          },
          "backlight": {
              "device": "intel_backlight",
              "format": "{percent}% {icon}",
              "format-icons": ["", ""]
          },
          "wireplumber": {
              //"scroll-step": 1,
              "format": "{volume}% {icon}",
              "format-muted": "",
              "format-icons": ["", "", ""],
              "on-click": "pavucontrol"
          },
      }
    '';
  };
}
