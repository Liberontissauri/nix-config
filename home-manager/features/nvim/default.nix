{
    programs.neovim.enable = true;
    home.file.".config/nvim".source = config.lib.file.mkOutOfStoreSymlink ./nvim;
}