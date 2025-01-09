{inputs, pkgs, config, lib, ...}:

{
  imports = [
    (inputs.nixos-apple-silicon + "/apple-silicon-support")
    ../../modules/nixos/default.nix
    #./hardware-configuration.nix
  ];
  config = {
    boot.loader.systemd-boot.enable = true;
    boot.loader.efi.canTouchEfiVariables = false;

    programs.fuse.userAllowOther = true;

    environment.systemPackages = with pkgs; [
      wayland
      killall
      fd
      btop
      gparted
      nix-doc
    ];

    programs.thunar.enable = true;
    services.gvfs.enable = true; # Mount, trash, and other functionalities
    services.tumbler.enable = true; # Thumbnail support for images

    services.gnome.gnome-keyring.enable = true;
    environment.variables.XDG_RUNTIME_DIR = "/run/user/$UID";
    programs.seahorse.enable = true;
    security.polkit.enable = true;

    programs.hyprland.enable = true;
    programs.fish.enable = true;

    security.rtkit.enable = true;
    services.pipewire = {
      enable = true;
      alsa.enable = true;
      alsa.support32Bit = true;
      pulse.enable = true;
      jack.enable = true;
    };

    nixpkgs = {
      overlays = [
      ];
      config = {
        allowUnfree = true;
      };
    };

    nix.settings.experimental-features = "nix-command flakes";
    nix.registry.nixpkgs.flake = inputs.nixpkgs;
    nix.channel.enable = true;
    environment.etc."nix/inputs/nixpkgs".source = "${inputs.nixpkgs}";
    nix.settings.nix-path = lib.mkForce "nixpkgs=${inputs.nixpkgs}";

    fonts.fontDir.enable = true;

    networking.hostName = "hermes";
    networking.networkmanager.enable = true;
    users.users = {
      liberontissauri = {
        initialPassword = "password";
        shell = pkgs.fish;
        isNormalUser = true;
        extraGroups = ["wheel"];
      };
    };

    system.stateVersion = "24.11";
  };
}