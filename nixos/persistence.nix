{
  ...
}:
{
  environment.persistence."/persist" = {
    enable = true; 
    hideMounts = true;
    directories = [
      "/var/log"
      "/var/lib/bluetooth"
      "/var/lib/nixos"
      "/var/lib/systemd/coredump"
    ];
    files = [
      #"/etc/machine-id"
      #{ file = "/var/keys/secret_file"; parentDirectory = { mode = "u=rwx,g=,o="; }; }
    ];
    #users.liberontissauri = {
    #  directories = [
    #    "Downloads"
    #    "Music"
    #    "Pictures"
    #    "Documents"
    #    "Videos"
    #    "VirtualBox VMs"
    #    { directory = ".gnupg"; mode = "0700"; }
    #    { directory = ".ssh"; mode = "0700"; }
    #    { directory = ".nixops"; mode = "0700"; }
    #    { directory = ".local/share/keyrings"; mode = "0700"; }
    #    ".local/share/direnv"
         # Programs
    #    ".config/Bitwarden"
    #    ".mozilla/firefox" # want to make this more narrowed down in the future
    #  ];
    #  files = [
    #    ".screenrc"
    #  ];
    #};
  };
}
