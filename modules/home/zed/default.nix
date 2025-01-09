{
  lib,
  config,
  pkgs,
  ...
}: {
  options.mine.zed.enable = lib.mkEnableOption "Enable zed";
  config = lib.mkIf config.mine.zed.enable {
    home.packages = with pkgs; [
      zed-editor
    ];
    home.file.".config/zed/settings.json".source = config.lib.file.mkOutOfStoreSymlink /persist/nix-config/modules/home/zed/settings.json;
  };
}
