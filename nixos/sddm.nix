{...}: {
  services.displayManager.defaultSession = "hyprland";
  services.displayManager.sddm = {
    enable = false;
    wayland.enable = true;
    sugarCandyNix = {
      enable = true;
      settings = {
        ScreenWidth = 2560;
        ScreenHeight = 1440;
        FormPosition = "left";
        HaveFormBackground = true;
        PartialBlur = true;
      };
    };
  };
}
