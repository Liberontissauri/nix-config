{
  lib,
  pkgs,
  ...
}: let
  bar_color = "00041D";
  text_color = "F9F9FB";
  selected_workspace = "87D2EF";
in {
  programs.waybar.enable = true;
  programs.waybar.settings = {
    mainBar = {
      layer = "top";
      position = "bottom";

      modules-left = ["clock" "hyprland/workspaces"];
      modules-center = [];
      modules-right = [];

      "hyprland/workspaces" = {
        format = "{icon}";
        format-icons = {
          default = "";
          active = "";
        };
      };

      "custom/hello-from-waybar" = {
        format = "hello {}";
        max-length = 40;
        interval = "once";
        exec = pkgs.writeShellScript "hello-from-waybar" ''
          echo "from within waybar"
        '';
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
      background: #${bar_color};
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
      color: #${text_color};
      background: transparent;
      padding-right: 13px;
    }

    #workspaces button.active {
      background: transparent;
      color: #${selected_workspace};
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
      color: #ffffff;;
      /*background: #1A1826;*/
    }
  '';
}
