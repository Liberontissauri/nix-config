{
  config,
  pkgs,
  inputs,
  ...
}:
{
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
    userChrome = ''
    '';
    userContent = ''
    '';
  };
}