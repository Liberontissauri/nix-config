{...}: {
  imports = [
    ../alacritty.nix
    ../fish.nix
    ../wofi.nix
    ../code.nix
  ];
  stylix.enable = true;
  stylix.image = ./background.jpg;
  stylix.base16Scheme = ./colors.yaml;
  stylix.autoEnable = false;
}
