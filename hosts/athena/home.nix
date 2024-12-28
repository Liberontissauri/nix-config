{inputs, ...}: let
  stylix = inputs.stylix;
in
{
  imports = [
    stylix.homeManagerModules.stylix
  ];
  config.mine.hyprland.enable = true;
  config.mine.waybar_style_1.enable = true;
}
