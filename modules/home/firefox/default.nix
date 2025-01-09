{
lib,
config,
inputs,
...
}:
{
  options.mine.firefox.enable = lib.mkEnableOption "Enable firefox";
  config = lib.mkIf config.mine.zed.enable { # this says zed but it should be firefox
    programs.firefox.enable = true;
    programs.firefox.profiles.default = {
      extensions = with inputs.firefox-addons.packages."x86_64-linux"; [
              ublock-origin
              bitwarden
              darkreader
              sidebery
              simple-translate
            ];
      settings = {
        "extensions.autoDisableScopes" = 0;
        "toolkit.legacyUserProfileCustomizations.stylesheets" = true;
        "layers.acceleration.force-enabled" = true;
        "gfx.webrender.all" = true;
        "svg.context-properties.content.enabled" = true;
      };
    };
    home.file.".mozilla/firefox/default/chrome/userChrome.css".source = ./userChrome.css;
  };
}
