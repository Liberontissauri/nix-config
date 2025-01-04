{
  lib,
  config,
  ...
}:
{
  options.mine.zed.enable = lib.mkEnableOption "Enable zed";
  config = lib.mkIf config.mine.zed.enable {
    programs.zed-editor.enable = true;
  };
}