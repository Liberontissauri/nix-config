{ pkgs, config, ... }:
let
  user = "liberontissauri";

  platform = "intel";

  vfioIds = [ ];
in {
  imports = [
    ./gaming_vm.nix
  ];


  boot = {
    kernelModules = [ "kvm-${platform}" "vfio_virqfd" "vfio_pci" "vfio_iommu_type1" "vfio" ];
    kernelParams = [ "${platform}_iommu=on" "${platform}_iommu=pt" "kvm.ignore_msrs=1" ];
    extraModprobeConfig = "options vfio-pci ids=${builtins.concatStringsSep "," vfioIds}";
  };

  environment.etc."libvirt/hooks/qemu".text = ''
      #!/bin/bash

      set -e

      SCRIPT="./$1-$2-$3"
      if [ -f "$SCRIPT" ]; then
          . "$SCRIPT"
      fi
  ''; # Separe as {vm}-start-begin and {vm}-start-end (...) scripts

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

  users.users.${user}.extraGroups = [ "qemu-libvirtd" "libvirtd" "disk" ];
}
