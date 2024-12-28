{
  lib,
  pci_to_unbind,
  id_driver_map,
}:
let
  unbindDevice = device: ''
    echo "${device}" > /sys/bus/pci/devices/${device}/driver/unbind
  '';
  bindDevice = { id, driver }: ''
    echo "${id}" > /sys/bus/pci/driver/${driver}/bind
  '';
in
''
  #!/bin/bash
  
  ${lib.concatStringsSep "\n" (map unbindDevice pci_to_unbind)}
  ${lib.concatStringsSep "\n" (map bindDevice id_driver_map)}
''