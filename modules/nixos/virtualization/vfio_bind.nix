{
  lib,
  pci_to_unbind,
  id_driver_map,
}:
let
  unbindDevice = device: ''
    echo "${device}" > /sys/bus/pci/devices/${device}/driver/unbind
  '';
  # Its ugly how I have an unused but I dont want to through the trouble
  bindDevice = {id, driver}: ''
    echo "${id}" > /sys/bus/pci/drivers/vfio-pci/new_id
  '';
in
''
  #!/bin/bash

  ${lib.concatStringsSep "\n" (map unbindDevice pci_to_unbind)}
  ${lib.concatStringsSep "\n" (map bindDevice id_driver_map)}
''
