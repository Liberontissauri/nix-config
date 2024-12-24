{
  config,
  ...
}:
{
  programs.wofi = {
    enable = true;
    settings = {
      location = "center";
      width = 800;
      hide_scroll=true;
      normal_window=true;
      no_actions=true;
    };
    style = ''
      window {
        margin: 0px;
        border: none;
        background-color: ${config.lib.stylix.colors.withHashtag.base00};
      }

      #input {
        margin: 5px;
        border: none;
        color: ${config.lib.stylix.colors.withHashtag.base07};
        background-color: ${config.lib.stylix.colors.withHashtag.base04};
      }

      #inner-box {
        margin: 5px;
        border: none;
        background-color: ${config.lib.stylix.colors.withHashtag.base00};
      }

      #outer-box {
        margin: 5px;
        border: none;
        background-color: ${config.lib.stylix.colors.withHashtag.base00};
      }

      #scroll {
        margin: 0px;
        border: none;
      }

      #text {
        margin: 5px;
        border: none;
        color: ${config.lib.stylix.colors.withHashtag.base07};
      }

      #entry:selected {
        background-color: ${config.lib.stylix.colors.withHashtag.base04};
      }
    '';
  };
}