{
  lib,
  config,
  ...
}:
{
  home.file."${config.xdg.configHome}/background.png" = {
    source = ./background.jpg;
  };
}
