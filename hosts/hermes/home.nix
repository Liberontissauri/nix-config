{inputs, pkgs, ...}: let
    stylix = inputs.stylix;
in
{
  imports = [
    stylix.homeManagerModules.stylix
    ../../modules/home/no_persist.nix
  ];
  config.mine.hyprland.enable = true;
  config.mine.waybar_style_1.enable = true;

  config.mine.zed.enable = true;
  #config.mine.firefox.enable = false;

  config = {
    nixpkgs = {
      overlays = [
      ];
      config = {
        allowUnfree = true;
        allowUnfreePredicate = _: true;
      };
    };

    home = {
      username = "liberontissauri";
      homeDirectory = "/home/liberontissauri";
    };
    
    home.packages = with pkgs; [
      wget
      swaybg
      waybar
      vencord
      bitwarden-desktop
      obsidian
      deluge
      nerdfetch
      swi-prolog
      grim
      wl-clipboard
      slurp
      stremio
      vlc
      tidal-hifi
    ];

    programs.alacritty.enable = true;
    programs.home-manager.enable = true;
    programs.git.enable = true;
    programs.git.userEmail = "jp.liberon@gmail.com";
    programs.git.userName = "Liberontissauri";
    systemd.user.startServices = "sd-switch";

    home.stateVersion = "24.11";
  };
}
