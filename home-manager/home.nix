# This is your home-manager configuration file
# Use this to configure your home environment (it replaces ~/.config/nixpkgs/home.nix)
{
  inputs,
  lib,
  config,
  pkgs,
  ...
}: {
  # You can import other home-manager modules here
  imports = [
    # If you want to use home-manager modules from other flakes (such as nix-colors):
    # inputs.nix-colors.homeManagerModule

    # You can also split up your configuration and import pieces of it here:
    # ./nvim.nix
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

  #home.file."${config.xdg.configHome}" = {
  #  source = ./dotfiles/vaporwave-1;
  #  recursive = true;
  #};

  nixpkgs = {
    # You can add overlays here
    overlays = [
      # If you want to use overlays exported from other flakes:
      # neovim-nightly-overlay.overlays.default

      # Or define it inline, for example:
      # (final: prev: {
      #   hi = final.hello.overrideAttrs (oldAttrs: {
      #     patches = [ ./change-hello-to-hi.patch ];
      #   });
      # })
    ];
    # Configure your nixpkgs instance
    config = {
      # Disable if you don't want unfree packages
      allowUnfree = true;
      # Workaround for https://github.com/nix-community/home-manager/issues/2942
      allowUnfreePredicate = _: true;
    };
  };

  home = {
    username = "liberontissauri";
    homeDirectory = "/home/liberontissauri";
  };

  # Add stuff for your user as you see fit:
  # programs.neovim.enable = true;
  # home.packages = with pkgs; [ steam ];
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
  # Enable home-manager and git
  programs.alacritty.enable = true;
  programs.home-manager.enable = true;
  programs.git.enable = true;
  programs.git.userEmail = "jp.liberon@gmail.com";
  programs.git.userName = "Liberontissauri";
  # Nicely reload system units when changing configs
  systemd.user.startServices = "sd-switch";

  # https://nixos.wiki/wiki/FAQ/When_do_I_update_stateVersion
  home.stateVersion = "24.11";
}
