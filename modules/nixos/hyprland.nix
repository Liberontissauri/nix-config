{lib, config, ...}:
{
  config = lib.mkIf config.mine.hyprland.enabled {
    programs.hyprland.enable = true; # Because hyprland should be a system package
  };
}