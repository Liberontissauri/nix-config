{lib, config, ...}: {
  options.mine.persistence.enable = lib.mkEnableOption "Enable persistence";
  config = lib.mkIf config.mine.persistence.enable {
    home.persistence."/persist/home/liberontissauri" = {
      directories = [
        "Downloads"
        "Music"
        "Pictures"
        "Documents"
        "Videos"
        "VirtualBox VMs"
        ".gnupg"
        ".ssh"
        ".nixops"
        ".local/share/keyrings"
        ".local/share/direnv"
        {
          directory = ".local/share/Steam";
          method = "symlink";
        }
        # [ PROGRAMS ]
        ".config/Bitwarden"
        ".mozilla/firefox" # want to make this more narrowed down in the future
        ".vscode" # Also want to make this more narrow
        ".config/Code" # maybe it was this
        ".config/discordcanary"
        ".config/obsidian"
        ".config/stremio"
        ".config/tidal-hifi"
      ];
      files = [
        ".screenrc"
      ];
      allowOther = true;
    };
  };
}