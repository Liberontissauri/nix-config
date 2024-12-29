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
    id_driver_map = lib.mkOption {
      type = lib.types.listOf (lib.types.attrsOf lib.types.str);
      default = {};
      description = "Map of PCI device IDs to drivers";
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
      pci_to_unbind = config.mine.virtualization.pci_to_bind;
      id_driver_map = config.mine.virtualization.id_driver_map;
    };

    environment.etc."libvirt/hooks/gaming-release-end".text = vfio_unbind {
      lib = lib;
      pci_to_unbind = config.mine.virtualization.pci_to_bind;
      id_driver_map = config.mine.virtualization.id_driver_map;
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

    systemd.tmpfiles.rules = [
      "f /dev/shm/looking-glass 0660 ${user} qemu-libvirtd -"
    ];

    users.users.${user}.extraGroups = ["qemu-libvirtd" "libvirtd" "disk"];
  };
}