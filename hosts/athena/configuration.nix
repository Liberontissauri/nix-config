{inputs, pkgs, config, lib, ...}:

{
  imports = [
    ../../modules/nixos/default.nix
  ];

  config.mine.disko.enable = true;
  config.mine.disko.device = "/dev/sda";
  config.mine.persistence.enable = true;
  config.mine.virtualization.enable = true;
  config.mine.virtualization.pci_to_bind = [
    "0000:09:00.0" # GPU_VIDEO
    "0000:09:00.1" # GPU_AUDIO
    "0000:04:00.0" # NVME_1
    "0000:05:00.0" # NVME_2 (Windows OS)
  ];
  config.mine.virtualization.id_driver_map = {
    "1002 73ff" = "amdgpu"; # GPU_VIDEO
    "1002 ab28" = "snd_hda_intel"; # GPU_AUDIO
    "10ec 5765" = "nvme"; # NVME_1
    "1e0f 0008" = "nvme"; # NVME_2
  };

  boot.loader.systemd-boot.enable = true;
  boot.loader.efi.canTouchEfiVariables = true;

  programs.fuse.userAllowOther = true;

  boot.extraModulePackages = [
    pkgs.linuxPackages.vendor-reset
  ];
  boot.supportedFilesystems = ["ntfs"];

  environment.systemPackages = with pkgs; [
    wayland
    killall
    fd
    btop
    gparted
    nix-doc
    
  ];

  # Virtualization
  boot.kernelParams = ["intel_iommu=on"];
  # /End/ Virtualization

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
  nix.channel.enable = false;
  environment.etc."nix/inputs/nixpkgs".source = "${inputs.nixpkgs}";
  nix.settings.nix-path = lib.mkForce "nixpkgs=${inputs.nixpkgs}";

  fonts.fontDir.enable = true;

  networking.hostName = "athena";
  users.users = {
    liberontissauri = {
      initialPassword = "password";
      shell = pkgs.fish;
      isNormalUser = true;
      extraGroups = ["wheel"];
    };
  };

  system.stateVersion = "24.11";
}