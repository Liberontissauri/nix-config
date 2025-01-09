{lib, pkgs, config, user, ...}:
let
  vfio_bind = import ./vfio_bind.nix;
  vfio_unbind = import ./vfio_unbind.nix;
in
{
  options.mine.virtualization = {
    enable = lib.mkEnableOption "Enable virtualization";
    cpu_platform = lib.mkOption {
      type = lib.types.str;
      default = "intel";
      description = "Intel or AMD CPU platform";
    };
    pci_to_bind = lib.mkOption {
      type = lib.types.listOf lib.types.str;
      default = [];
      description = "PCI devices to bind to vfio-pci";
    };
    slot_id_driver_map = lib.mkOption {
      type = lib.types.listOf (lib.types.attrsOf lib.types.str);
      default = {};
      description = "Map of PCI device IDs to drivers";
    };
    mouse_edev = lib.mkOption {
      type = lib.types.str;
      default = "";
      description = "Mouse event device";
    };
    keyboard_edev = lib.mkOption {
      type = lib.types.str;
      default = "";
      description = "Keyboard event device";
    };
  };

  config = lib.mkIf config.mine.virtualization.enable {
    boot = {
      kernelModules = ["kvm-${config.mine.virtualization.cpu_platform}" "vfio_virqfd" "vfio_pci" "vfio_iommu_type1" "vfio"];
      kernelParams = ["${config.mine.virtualization.cpu_platform}_iommu=on" "${config.mine.virtualization.cpu_platform}_iommu=pt" "kvm.ignore_msrs=1"];
      extraModprobeConfig = "options vfio-pci";
    };

    environment.etc."libvirt/hooks/qemu".text = ''
      #!/bin/bash

      set -e

      SCRIPT="./$1-$2-$3"
      if [ -f "$SCRIPT" ]; then
          . "$SCRIPT"
      fi
    ''; # Separe as {vm}-start-begin and {vm}-start-end (...) scripts

    environment.etc."libvirt/hooks/gaming-prepare-begin".text = vfio_bind {
      lib = lib;
      slot_id_driver_map = config.mine.virtualization.slot_id_driver_map;
    };

    environment.etc."libvirt/hooks/gaming-release-end".text = vfio_unbind {
      lib = lib;
      slot_id_driver_map = config.mine.virtualization.slot_id_driver_map;
    };


    environment.systemPackages = with pkgs; [
      virt-manager
      looking-glass-client
    ];

    virtualisation = {
      libvirtd = {
        enable = true;
        extraConfig = ''
          user="${user}"
        '';
        onBoot = "ignore";
        onShutdown = "shutdown";

        qemu = {
          package = pkgs.qemu_kvm;
          ovmf.enable = true;
        };
      };
    };
    # environment.etc."libvirt/qemu.conf".text = ''
    #   cgroup_device_acl = [
    #     "/dev/null", "/dev/full", "/dev/zero", 
    #     "/dev/random", "/dev/urandom",
    #     "/dev/ptmx", "/dev/kvm", "/dev/kqemu",
    #     "/dev/rtc","/dev/hpet",
    #     "/dev/input/by-id/usb-SEMITEK_USB-HID_Gaming_Keyboard_SN0000000001-event-kbd",
    #     "/dev/input/by-id/usb-Razer_Razer_DeathAdder_2013-mouse"
    #   ]
    # '';
    # services.udev.extraRules = ''
    #   SUBSYSTEM=="usb", ATTR{idVendor}=="0037", ATTR{idProduct}=="1532", MODE="0666"
    #   SUBSYSTEM=="usb", ATTR{idVendor}=="0907", ATTR{idProduct}=="1ea7", MODE="0666"
    # '';

    systemd.tmpfiles.rules = [
      "f /dev/shm/looking-glass 0660 ${user} qemu-libvirtd -"
    ];

    users.users.${user}.extraGroups = ["qemu-libvirtd" "libvirtd" "disk"];
  };
}