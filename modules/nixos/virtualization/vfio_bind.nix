{
  lib,
  slot_id_driver_map,
}:
let
  unbindDevice = { slot, id, driver }: ''
    echo "${slot}" > /sys/bus/pci/devices/${slot}/driver/unbind
  '';
  # Its ugly how I have an unused but I dont want to through the trouble
  bindDevice = { slot, id, driver }: ''
    echo "${id}" > /sys/bus/pci/drivers/vfio-pci/new_id
    echo "${slot}" >  /sys/bus/pci/drivers/vfio-pci/bind
  '';
in
''
  #!/bin/bash

  ${lib.concatStringsSep "\n" (map unbindDevice slot_id_driver_map)}
  ${lib.concatStringsSep "\n" (map bindDevice slot_id_driver_map)}
''
