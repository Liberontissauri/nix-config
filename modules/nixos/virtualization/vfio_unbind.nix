{
  lib,
  slot_id_driver_map,
}:
let
  unbindDevice = { slot, id, driver }: ''
    echo "${slot}" > /sys/bus/pci/devices/${slot}/driver/unbind
  '';
  bindDevice = { slot, id, driver }: '' # THIS IS WRONG, IT SHOULD USE THE PCI SLOT
    echo "${slot}" > /sys/bus/pci/drivers/${driver}/bind
  '';
in
''
  #!/bin/bash
  
  ${lib.concatStringsSep "\n" (map unbindDevice slot_id_driver_map)}
  ${lib.concatStringsSep "\n" (map bindDevice slot_id_driver_map)}
''