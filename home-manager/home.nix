{
  pkgs,
  ...
}: {
  imports = [
    ./features/hyprland.nix
    ./features/fonts.nix
    ./features/waybar.nix
    ./features/background
    ./themes/blue-sky.nix
    ./features/firefox.nix
    ./features/persistence.nix
    ./features/fastfetch.nix
    ./features/helper.nix
    ./features/nvim.nix
  ];
  
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
}
