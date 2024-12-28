{...}: {
  environment.etc.machine-id.text = "2137d962e10e445e8038329cb990137a";
  environment.persistence."/persist" = {
    enable = true;
    hideMounts = true;
    directories = [
      "/var/log"
      "/var/lib/bluetooth"
      "/var/lib/nixos"
      "/var/lib/systemd/coredump"
      "/var/lib/libvirt"
    ];
  };
}
