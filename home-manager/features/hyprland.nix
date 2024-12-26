{
  lib,
  ...
}:
let 
  active_border_color = "D4618300";
  inactive_border_color = "ffffff00";
  floating_border_color = "013861aa";
in {
  wayland.windowManager.hyprland = {
    enable=true;
    extraConfig = ''
      env = AQ_DRM_DEVICES,/dev/dri/card1

      monitor=,2560x1440@75,auto,1

      exec-once = swaybg -m fill -i ~/.config/background.png & waybar

      $terminal = alacritty
      $fileManager = thunar

      env = XCURSOR_SIZE,24
      env = QT_QPA_PLATFORMTHEME,qt5ct # change to qt6ct if you have that
      env = GDK_BACKEND,wayland,x11,*

      input {
          kb_layout = us

          follow_mouse = 1

          touchpad {
              natural_scroll = false
          }
          accel_profile = adaptive
          sensitivity = -0.4 # -1.0 - 1.0, 0 means no modification.
      }

      general {
          gaps_in = 5
          gaps_out = 40
          border_size = 0
          col.active_border = rgba(${active_border_color}) rgba(${active_border_color}) 45deg
          col.inactive_border = rgba(${inactive_border_color})

          layout = dwindle
      }
      windowrulev2 = bordercolor rgba(${floating_border_color}) rgba(${floating_border_color}),floating:1
      windowrulev2 = bordersize 5,floating:1

      decoration {
          rounding = 0
          blur {
              enabled = true
              size = 3
              passes = 1
              
              vibrancy = 0.1696
          }
          shadow {
              enabled =false
          }
      }

      animations {
          enabled = true

          bezier = myBezier, 0.05, 0.9, 0.1, 1.05
          bezier = workspaceBezier, 0, 1, 0.21, 1

          animation = windows, 1, 7, myBezier
          animation = windowsOut, 1, 7, default, popin 80%
          animation = border, 1, 10, default
          animation = borderangle, 1, 8, default
          animation = fade, 1, 7, default
          animation = workspaces, 1, 3, workspaceBezier, slidefade
      }

      dwindle {
          pseudotile = true # master switch for pseudotiling. Enabling is bound to mainMod + P in the keybinds section below
          preserve_split = true # you probably want this
      }

      misc {
          # See https://wiki.hyprland.org/Configuring/Variables/ for more
          force_default_wallpaper = -1 # Set to 0 or 1 to disable the anime mascot wallpapers
      }

      windowrule=float,Rofi

      # See https://wiki.hyprland.org/Configuring/Keywords/ for more
      $mainMod = SUPER
      $secondMod = ALT

      bind =, XF86AudioRaiseVolume, exec, wpctl set-volume -l 1.4 @DEFAULT_AUDIO_SINK@ 5%+
      bind =, XF86AudioLowerVolume, exec, wpctl set-volume -l 1.4 @DEFAULT_AUDIO_SINK@ 5%-

      bind = $mainMod, RETURN, exec, $terminal
      bind = $secondMod SHIFT, Q, killactive,
      bind = $mainMod SHIFT, Escape, exit,
      bind = $mainMod, E, exec, $fileManager
      bind = $mainMod, Space, exec, wofi --show drun,
      bind = $mainMod, F, togglefloating,
      bind = $mainMod SHIFT, F,fullscreen 
      bind = $mainMod, P, pseudo, # dwindle
      bind = $mainMod, J, togglesplit, # dwindle

      bind = $mainMod, left, movefocus, l
      bind = $mainMod, right, movefocus, r
      bind = $mainMod, up, movefocus, u
      bind = $mainMod, down, movefocus, d

      bind = $mainMod, 1, workspace, 1
      bind = $mainMod, 2, workspace, 2
      bind = $mainMod, 3, workspace, 3
      bind = $mainMod, 4, workspace, 4
      bind = $mainMod, 5, workspace, 5
      bind = $mainMod, 6, workspace, 6
      bind = $mainMod, 7, workspace, 7
      bind = $mainMod, 8, workspace, 8
      bind = $mainMod, 9, workspace, 9
      bind = $mainMod, 0, workspace, 10

      bind = $mainMod SHIFT, 1, movetoworkspace, 1
      bind = $mainMod SHIFT, 2, movetoworkspace, 2
      bind = $mainMod SHIFT, 3, movetoworkspace, 3
      bind = $mainMod SHIFT, 4, movetoworkspace, 4
      bind = $mainMod SHIFT, 5, movetoworkspace, 5
      bind = $mainMod SHIFT, 6, movetoworkspace, 6
      bind = $mainMod SHIFT, 7, movetoworkspace, 7
      bind = $mainMod SHIFT, 8, movetoworkspace, 8
      bind = $mainMod SHIFT, 9, movetoworkspace, 9
      bind = $mainMod SHIFT, 0, movetoworkspace, 10

      bind = $mainMod SHIFT, S, exec, grim -g "$(slurp)" - | wl-copy

      bind = $mainMod, mouse_down, workspace, e+1
      bind = $mainMod, mouse_up, workspace, e-1

      bindm = $mainMod, mouse:272, movewindow
      bindm = $mainMod, mouse:273, resizewindow

      bind = $mainMod, D, togglespecialworkspace, magic
      bind = $mainMod SHIFT, D, movetoworkspace, special:magic
    '';
  };
}
