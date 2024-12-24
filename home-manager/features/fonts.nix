{
  lib,
  pkgs,
  ...
}:
{
  home.packages = with pkgs; [
    (pkgs.nerdfonts.override {
      fonts = [
        "JetBrainsMono"
        "Iosevka"
        "IosevkaTerm"
      ];
    })
  ]; 
}