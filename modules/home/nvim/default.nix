{
lib,
config,
inputs,
pkgs,
...
}:
{
  options.mine.nvim.enable = lib.mkEnableOption "Enable Neovim";
  config = lib.mkIf config.mine.firefox.enable { 
    home.packages = with pkgs; [
   	neovim 
    ]
    home.file.".config/nvim".source = config.lib.file.mkOutOfStoreSymlink ./nvim;
  };
}
