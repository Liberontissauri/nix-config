{lib, config, ...}: 
let
  hyprlandExtraConfig = {
    desktop = ''
      env = AQ_DRM_DEVICES,/dev/dri/card1
      monitor=,2560x1440@75,auto,1
      
      input {
          kb_layout = us

          follow_mouse = 1

          touchpad {
              natural_scroll = false
          }
          accel_profile = adaptive
          sensitivity = -0.4 # -1.0 - 1.0, 0 means no modification.
      }
      # Unity stuff 
      
      # Certain windows need a min size due to this issue: https://discussions.unity.com/t/engine-menus-can-only-be-opened-once/1521080/3
      windowrulev2 = minsize 250 250, class:^(Unity)$, title:^(Project Settings)$
      windowrulev2 = minsize 250 250, class:^(Unity)$, title:^(Preferences)$
      windowrulev2 = minsize 250 250, class:^(Unity)$, title:^(UnityEditor.AddComponent.AddComponentWindow)$
      windowrulev2 = minsize 250 500, class:^(Unity)$, title:^(Package Manager)$
      windowrulev2 = minsize 250 250, class:^(Unity)$, title:^(UnityEditor.PackageManager.UI.Internal.DropdownContainer)$
      windowrulev2 = minsize 250 250, class:^(Unity)$, title:^(UI Toolkit Debugger)$
      windowrulev2 = minsize 250 500, class:^(Unity)$, title:^(Font Asset Creator)$
      windowrulev2 = minsize 500 250, class:^(Unity)$, title:^(Background Tasks)$
      windowrulev2 = minsize 500 250, class:^(Unity)$, title:^(Mod Builder)$
      windowrulev2 = minsize 500 250, class:^(Unity)$, title:^(Profiler)$
      windowrulev2 = minsize 500 250, class:^(Unity)$, title:^(Render Graph Viewer)$
      windowrulev2 = minsize 500 250, class:^(Unity)$, title:^(Game)$
      windowrulev2 = minsize 500 250, class:^(Unity)$, title:^(Shortcuts)$
      windowrulev2 = minsize 500 250, class:^(Unity)$, title:^(NormalMap settings)$

      # Tooltips Stealing Focus
      # Discussions: https://discussions.unity.com/t/unset-tooltip-titles/1522964
      # Support: https://unity3d.atlassian.net/servicedesk/customer/portal/2/IN-85635
      # Issue Tracker: https://issuetracker.unity3d.com/issues/linux-tooltips-have-an-unset-title-which-causes-the-inability-to-modify-tooltip-behavior-on-window-managers
      # Thanks Unity devs <3
      windowrulev2 = nofocus, class:^(Unity)$, title:^(UnityTooltipWindow)$

      #Open at cursor position
      #windowrulev2 = move cursor, class:^(Unity)$ #Enable if you want literally everything to be moved to cursor pos(has downsides)

      # Icon Selector
      windowrulev2 = move cursor, class:^(Unity)$, title:^(UnityEditor.IconSelector)$
      windowrulev2 = minsize 250 250, class:^(Unity)$, title:^(UnityEditor.IconSelector)$


      #Color Picker
      windowrulev2 = move cursor, class:^(Unity)$, title:^(Color)$
      windowrulev2 = move cursor, class:^(Unity)$, title:^(HDR Color)$
      windowrulev2 = minsize 250 250, class:^(Unity)$, title:^(Color)$
      windowrulev2 = minsize 250 250, class:^(Unity)$, title:^(HDR Color)$

      #Gradient
      windowrulev2 = move cursor, class:^(Unity)$, title:^(Gradient Editor)(.*)$
      windowrulev2 = move cursor, class:^(Unity)$, title:^(HDR Gradient Editor)(.*)$
      windowrulev2 = minsize 250 250, class:^(Unity)$, title:^(Gradient Editor)(.*)$
      windowrulev2 = minsize 250 250, class:^(Unity)$, title:^(HDR Gradient Editor)(.*)$

      #Object Selection
      windowrulev2 = move cursor, class:^(Unity)$, title:^(Select)(.*)$
      windowrulev2 = minsize 250 250, class:^(Unity)$, title:^(Select)(.*)$

      # Mesh Selection
      windowrulev2 = move cursor, class:^(Unity)$, title:^(Select Mesh)(.*)$
      windowrulev2 = minsize 250 250, class:^(Unity)$, title:^(Select Mesh)(.*)$

      #Add Override
      windowrulev2 = move cursor, class:^(Unity)$, title:^(UnityEditor.Rendering.FilterWindow)(.*)$
      windowrulev2 = minsize 250 250, class:^(Unity)$, title:^(UnityEditor.Rendering.FilterWindow)(.*)$

      #Animation Curve
      windowrulev2 = move cursor, class:^(Unity)$, title:^(Curve)(.*)$
      windowrulev2 = minsize 250 250, class:^(Unity)$, title:^(Curve)(.*)$

      #Add Component
      windowrulev2 = move cursor, class:^(Unity)$, title:^(UnityEditor.AddComponent.AddComponentWindow)$
      windowrulev2 = minsize 250 250, class:^(Unity)$, title:^(UnityEditor.AddComponent.AddComponentWindow)$

      #Material Shadedr Dropdown
      windowrulev2 = move cursor, class:^(Unity)$, title:^(UnityEditor.IMGUI.Controls.AdvancedDropdownWindow)$
      windowrulev2 = minsize 250 250, class:^(Unity)$, title:^(UnityEditor.IMGUI.Controls.AdvancedDropdownWindow)$

      #Shader Graph Add Node
      windowrulev2 = move cursor, class:^(Unity)$, title:^(UnityEditor.Searcher.SearcherWindow)$
      windowrulev2 = minsize 250 250, class:^(Unity)$, title:^(UnityEditor.Searcher.SearcherWindow)$

      #VFX Graph
      windowrulev2 = move cursor, class:^(Unity)$, title:^(UnityEditor.VFX.UI.VFXFilterWindow)$
      windowrulev2 = minsize 250 500, class:^(Unity)$, title:^(UnityEditor.VFX.UI.VFXFilterWindow)$

      #UI Builder
      windowrulev2 = move cursor, class:^(Unity)$, title:^(UI Builder)$
      windowrulev2 = minsize 1000 750, class:^(Unity)$, title:^(UI Builder)$

      #UI Toolkit Windows
      windowrulev2 = minsize 200 50, class:^(Unity)$, title:^(Nisualizer Scene Creator)$


      windowrulev2 = move cursor, class:^(Unity)$, title:^(UnityEditor.Rendering.FilterWindow)$
      windowrulev2 = move cursor, class:^(Unity)$, title:^(UnityEditor.IMGUI.Controls.AdvancedDropdownWindow)$ #Animation Conditions
      windowrulev2 = move cursor, class:^(Unity)$, title:^(UnityEngine.InputSystem.Editor.AdvancedDropdownWindow)$ #Input Dropdown
      windowrulev2 = move cursor, class:^(Unity)$, title:^(UnityEditorInternal.AddCurvesPopup)$ #Add Animation Property

      #Themes
      windowrulev2 = minsize 250 250, class:^(Unity)$, title:^(Theme Settings)$
      windowrulev2 = minsize 250 250, class:^(Unity)$, title:^(Create Theme)$
      windowrulev2 = minsize 250 250, class:^(Unity)$, title:^(Edit Theme)$
    '';
    asahi = ''
      monitor=,2560x1440@120,auto,1.333
      
      input {
          kb_layout = pt
	  kb_variant = mac

          follow_mouse = 1

          touchpad {
              natural_scroll = true
          }
          sensitivity = 0
      }
    '';
  };
in
{
  options.mine.hyprland.enable = lib.mkEnableOption "Enable hyprland";
  options.mine.hyprland.system = lib.mkOption {
    type = lib.types.str;
    default = "desktop";
    description = "System type for hyprland. \"desktop\" or \"asahi\"";
  };
  options.mine.hyprland.accent_color = lib.mkOption {
    type = lib.types.str;
    default = "1A1826";
    description = "Accent color";
  };
  config = lib.mkIf config.mine.hyprland.enable {
    wayland.windowManager.hyprland = {
      enable = true;
      extraConfig = ''
        ${hyprlandExtraConfig.${config.mine.hyprland.system}}

        exec-once = swaybg -m fill -i ~/.config/background.png & waybar

        $terminal = alacritty
        $fileManager = thunar

        env = XCURSOR_SIZE,24
        env = QT_QPA_PLATFORMTHEME,qt5ct # change to qt6ct if you have that
        env = GDK_BACKEND,wayland,x11,*

        general {
            gaps_in = 5
            gaps_out = 40
            border_size = 0
            col.active_border = rgba(ffffff00) rgba(ffffff00) 45deg
            col.inactive_border = rgba(ffffff00)

            layout = dwindle
        }
        windowrulev2 = bordercolor rgba(${config.mine.hyprland.accent_color}) rgba(${config.mine.hyprland.accent_color}),floating:1
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
  };
}
