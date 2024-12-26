{ lib, ... }:

{
  services.displayManager.defaultSession = "hyprland";
  services.displayManager.sddm = {
    enable = true; # Enable SDDM.
    wayland.enable = true;
    sugarCandyNix = {
        enable = true; # This set SDDM's theme to "sddm-sugar-candy-nix".
        settings = {
          # Set your configuration options here.
          # Here is a simple example:
          ScreenWidth = 2560;
          ScreenHeight = 1440;
          FormPosition = "left";
          HaveFormBackground = true;
          PartialBlur = true;
          # ...
        };
      };
    };
}
