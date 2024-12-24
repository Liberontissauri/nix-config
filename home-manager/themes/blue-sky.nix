{

  ...
}:
{
  imports = [
    ../features/alacritty.nix
    ../features/fish.nix
    ../features/wofi.nix
    ../features/code.nix
  ];
  stylix.enable = true;
  stylix.image = ./background.jpg;
  stylix.base16Scheme = ./colors.yaml;
  stylix.autoEnable = false;
}