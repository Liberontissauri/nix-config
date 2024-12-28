{...}: let
  PCI_GPU_VIDEO = "0000:09:00.0";
  PCI_GPU_AUDIO = "0000:09:00.1";
  ID_GPU_VIDEO = "1002 73ff";
  ID_GPU_AUDIO = "1002 ab28";
  PCI_NVME_1 = "0000:04:00.0";
  PCI_NVME_2 = "0000:05:00.0";
in {
  environment.etc."libvirt/hooks/win10-prepare-begin".text = ''
    #!/bin/bash


    echo "${PCI_GPU_VIDEO}" > /sys/bus/pci/devices/${PCI_GPU_VIDEO}/driver/unbind
    echo "${PCI_GPU_AUDIO}" > /sys/bus/pci/devices/${PCI_GPU_AUDIO}/driver/unbind
    echo "${PCI_NVME_1}" > /sys/bus/pci/devices/${PCI_NVME_1}/driver/unbind
    echo "${PCI_NVME_2}" > /sys/bus/pci/devices/${PCI_NVME_2}/driver/unbind

    echo "${ID_GPU_VIDEO}" > /sys/bus/pci/drivers/vfio-pci/new_id
    echo "${ID_GPU_AUDIO}" > /sys/bus/pci/drivers/vfio-pci/new_id
    echo "${PCI_NVME_1}" > /sys/bus/pci/drivers/vfio-pci/new_id
    echo "${PCI_NVME_2}" > /sys/bus/pci/drivers/vfio-pci/new_id
  '';
  environment.etc."libvirt/hooks/win10-release-end".text = ''
    #!/bin/bash

    PCI_GPU_VIDEO="0000:09:00.0"
    PCI_GPU_AUDIO="0000:09:00.1"
    PCI_NVME_1="0000:04:00.0"
    PCI_NVME_2="0000:05:00.0"

    echo "${PCI_GPU_VIDEO}" > /sys/bus/pci/drivers/vfio-pci/unbind
    echo "${PCI_GPU_AUDIO}" > /sys/bus/pci/drivers/vfio-pci/unbind
    echo "${PCI_NVME_1}" > /sys/bus/pci/drivers/vfio-pci/unbind
    echo "${PCI_NVME_2}" > /sys/bus/pci/drivers/vfio-pci/unbind

    echo "${PCI_GPU_VIDEO}" > /sys/bus/pci/drivers/amdgpu/bind
    echo "${PCI_GPU_AUDIO}" > /sys/bus/pci/drivers/snd_hda_intel/bind
    echo "${PCI_NVME_1}" > /sys/bus/pci/drivers/nvme/bind
    echo "${PCI_NVME_2}" > /sys/bus/pci/drivers/nvme/bind
  '';
}
