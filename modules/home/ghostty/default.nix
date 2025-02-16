{
lib,
config,
inputs,
pkgs,
...
}:
{
  options.mine.ghostty.enable = lib.mkEnableOption "Enable Ghostty";
  config = lib.mkIf config.mine.ghostty.enable { 
    programs.ghostty.enable = true;
    home.file.".config/ghostty".source = config.lib.file.mkOutOfStoreSymlink /persist/nix-config/modules/home/ghostty/ghostty;
    home.file.".config/ghostty".recursive = true;
    };
}
