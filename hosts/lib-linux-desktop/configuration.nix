{inputs, pkgs, config, lib, ...}:

{
  imports = [
    ../../modules/nixos/default.nix
    ./hardware-configuration.nix
  ];

  config.mine.disko.enable = true;
  config.mine.disko.device = "/dev/sda";
  config.mine.persistence.enable = true;
  config.mine.virtualization.enable = true;

  config.mine.virtualization.slot_id_driver_map = [
    {slot="0000:09:00.0"; id = "1002 73ff"; driver = "amdgpu"; } # GPU_VIDEO
    { slot="0000:09:00.1" ;id = "1002 ab28"; driver = "snd_hda_intel"; } # GPU_AUDIO
    { slot="0000:04:00.0" ;id = "10ec 5765"; driver = "nvme"; } # NVME_1
    { slot="0000:05:00.0" ;id = "1e0f 0008"; driver = "nvme"; } # NVME_2
  ];

  config.mine.virtualization.mouse_edev = "usb-Razer_Razer_DeathAdder_2013-mouse";
  config.mine.virtualization.keyboard_edev = "usb-SEMITEK_USB-HID_Gaming_Keyboard_SN0000000001-event-kbd";
  
  config = {
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
      docker-compose
      jetbrains.rider
      gcc
      gnumake
      ripgrep
      python3
    ];

    services.zerotierone = {
      enable = true;
      joinNetworks = [
      ];
      port = 9993;
    };

    programs.thunar.enable = true;
    services.gvfs.enable = true; # Mount, trash, and other functionalities
    services.tumbler.enable = true; # Thumbnail support for images
    

    virtualisation.docker.enable = true;
    virtualisation.docker.storageDriver = "btrfs";
    virtualisation.docker.rootless = {
      enable = true;
      setSocketVariable = true;
    };
    virtualisation.docker.daemon.settings = {
      data-root = "/home/liberontissauri/.local/share/docker_data";
    };

    
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
    nix.channel.enable = true;
    environment.etc."nix/inputs/nixpkgs".source = "${inputs.nixpkgs}";
    nix.settings.nix-path = lib.mkForce "nixpkgs=${inputs.nixpkgs}";

    fonts.fontDir.enable = true;

    networking.hostName = "lib-linux-desktop";
    users.users = {
      liberontissauri = {
        initialPassword = "password";
        shell = pkgs.fish;
        isNormalUser = true;
        extraGroups = ["wheel" "docker"];
      };
    };

    system.stateVersion = "24.11";
  };
}