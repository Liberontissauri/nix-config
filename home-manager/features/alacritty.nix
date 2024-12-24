{
  config,
  ...
}:
{
  programs.alacritty.enable = true;
  programs.alacritty.settings = {
    font = {
      normal = {
        family = "JetbrainsMono Nerd Font";
        style = "Regular";
      };
      bold = {
        family = "JetbrainsMono Nerd Font";
        style = "Bold";
      };
      size = 14;
    };
    window = {
      padding = {
      x = 25;
      y = 25;
      };
    };
    colors = {
      primary = {
        background = config.lib.stylix.colors.withHashtag.base01;
        foreground = config.lib.stylix.colors.withHashtag.base07;
      };
      normal = {
        black = config.lib.stylix.colors.withHashtag.base03;
        red = config.lib.stylix.colors.withHashtag.base08;
        green = config.lib.stylix.colors.withHashtag.base0B;
        yellow = config.lib.stylix.colors.withHashtag.base0A;
        blue = config.lib.stylix.colors.withHashtag.base0D;
        magenta = config.lib.stylix.colors.withHashtag.base0E;
        cyan = config.lib.stylix.colors.withHashtag.base0C;
        white = config.lib.stylix.colors.withHashtag.base07;
      };
      bright = {
        black = config.lib.stylix.colors.withHashtag.base03;
        red = config.lib.stylix.colors.withHashtag.base08;
        green = config.lib.stylix.colors.withHashtag.base0B;
        yellow = config.lib.stylix.colors.withHashtag.base0A;
        blue = config.lib.stylix.colors.withHashtag.base0D;
        magenta = config.lib.stylix.colors.withHashtag.base0E;
        cyan = config.lib.stylix.colors.withHashtag.base0C;
        white = config.lib.stylix.colors.withHashtag.base07;
      };
    };
  };
}