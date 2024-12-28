{
  inputs,
  pkgs,
  ...
}:
{
  nixpkgs.overlays = [
    inputs.nvim-config.overlays.default
  ];
  home.packages = with pkgs; [
    nvim-pkg
  ];
}