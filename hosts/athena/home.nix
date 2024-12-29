{inputs, pkgs, ...}: let
  impermanence = inputs.impermanence;
  stylix = inputs.stylix;
in
{
  imports = [
    impermanence.homeManagerModules.impermanence
    stylix.homeManagerModules.stylix
    ../../modules/home

  ];
  config.mine.persistence.enable = true; # VERY IMPORTANT OR ELSE YOU WILL LOSE DATA
  config.mine.hyprland.enable = true;
  config.mine.waybar_style_1.enable = true;

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
      discord-canary
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
