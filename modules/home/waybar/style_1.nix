{lib, config, pkgs, ...}:
let
    waybarModulesConfig = {
    desktop = [];
    asahi = ["battery"];
    };
in
{
  options.mine.waybar_style_1.enable = lib.mkEnableOption "Enable waybar style 1";
  options.mine.waybar_style_1.system = lib.mkOption {
    type = lib.types.str;
    default = "desktop";
    description = "System type for waybar. \"desktop\" or \"asahi\"";
  };
  options.mine.waybar_style_1.bar_color = lib.mkOption {
    type = lib.types.str;
    default = "00041D";
    description = "Bar color";
  };
  options.mine.waybar_style_1.text_color = lib.mkOption {
    type = lib.types.str;
    default = "F9F9FB";
    description = "Text color";
  };
  options.mine.waybar_style_1.highlight_color = lib.mkOption {
    type = lib.types.str;
    default = "87D2EF";
    description = "Highlights color";
  };
  options.mine.waybar_style_1.battery.enable = lib.mkEnableOption "Enable battery modules";
  options.mine.waybar_style_1.network.enable = lib.mkEnableOption "Enable network modules"; # Not working yet
  
  config = lib.mkIf config.mine.waybar_style_1.enable {
    programs.waybar.enable = true;
    programs.waybar.settings = {
      mainBar = {
        layer = "top";
        position = "bottom";

        modules-left = ["clock" "hyprland/workspaces"];
        modules-center = [];
        modules-right = waybarModulesConfig.${config.mine.waybar_style_1.system};

        "hyprland/workspaces" = {
          format = "{icon}";
          format-icons = {
            default = "";
            active = "";
          };
        };

        "battery" = {
          format = "{icon} {capacity}%";
          interval = "20";
          format-icons = ["" "" "" ""];
          formate-charging="󱐋 {capacity}%";
        };
        
        "network"= {
            format = "{icon}";
            format-alt = "{ipaddr}/{cidr} ({signalStrength}%)";
            format-alt-click = "click-right";
            format-wifi = " {essid} ";
            format-ethernet = " Ethernet";
            format-disconnected = "⚠ Disconnected";
            tooltip = false;
        };
      };
    };

    programs.waybar.style = ''
      * {
        border: none;
        border-radius: 0;
          font-family: "JetbrainsMono Nerd Font" ;
        font-size: 20px;
      }

      window#waybar {
        background: #${config.mine.waybar_style_1.bar_color};
        opacity: 0.9;
      }

      window#waybar.hidden {
        opacity: 0.6;
      }

      #window {
        transition: none;
        color: transparent;
        background: transparent;
      }

      #workspaces button {
        color: #${config.mine.waybar_style_1.text_color};
        background: transparent;
        padding-right: 13px;
      }

      #workspaces button.active {
        background: transparent;
        color: #${config.mine.waybar_style_1.highlight_color};
      }

      #clock {
        margin-top: 10px;
        margin-bottom: 10px;
        margin-left: 8px;
        margin-right: 15px;
        padding-left: 30px;
        padding-right: 10px;
        border-radius: 10px;
        transition: none;
        color: #ffffff;
        /*background: #1A1826;*/
      }
      #network {
        margin-top: 10px;
        margin-bottom: 10px;
        margin-left: 15px;
        margin-right: 8px;
        padding-left: 10px;
        padding-right: 30px;
        border-radius: 10px;
        transition: none;
        color: #ffffff;
        /*background: #1A1826;*/
      }
      #battery {
        margin-top: 10px;
        margin-bottom: 10px;
        margin-left: 15px;
        margin-right: 8px;
        border-radius: 10px;
        transition: none;
        color: #ffffff;
        /*background: #1A1826;*/
      }
    '';
  };
}