{
  pkgs,
  ...
}:
{
  home.packages = with pkgs; [
    nixd
    alejandra
  ];
  programs.vscode.enable = true;
  programs.vscode.userSettings = {
    "files.autoSave" = "afterDelay";
    "workbench.colorTheme" = "GitHub Dark Colorblind (Beta)";
    "workbench.iconTheme" = "eq-material-theme-icons";
    "prolog.executablePath" = "/etc/profiles/per-user/liberontissauri/bin/swipl";
    "nix.serverPath" = "nixd";
    "nix.enableLanguageServer" = true;
    "nix.serverSettings" = {
      "nixd" = {
        "formatting" = {
          "command" = [ "alejandra" ];
        };
         "options" = {
            "nixos" = {
              "expr" = "(builtins.getFlake \"/persist/nix-config/flake.nix\").nixosConfigurations.lib-desktop.options";
            };
            #"home_manager" = {
            #  "expr" = "(builtins.getFlake \"/persist/nix-config/home-manager/home.nix\").homeConfigurations.lib-desktop.options";
            #};
         };
      };
    };
  };
  programs.vscode.extensions = [
    pkgs.vscode-extensions.github.github-vscode-theme
    pkgs.vscode-extensions.github.copilot
    pkgs.vscode-extensions.equinusocio.vsc-material-theme-icons
  ] ++ pkgs.vscode-utils.extensionsFromVscodeMarketplace [
     {
         name = "VSC-Prolog";
         publisher = "arthurwang";
         version = "0.8.23";
         sha256 = "sha256-Da2dCpruVqzP3g1hH0+TyvvEa1wEwGXgvcmIq9B/2cQ=";
     }
     {
         name = "better-prolog-syntax";
         publisher = "jeff-hykin";
         version = "0.3.2";
         sha256 = "sha256-P3zeOaZB4sy7hCVSu/WQwvuyj+qXwwfbcdNCRg1T0EM=";
     }
     {
        name = "nix-ide";
        publisher = "jnoortheen";
        version = "0.3.5";
        sha256="sha256-hiyFZVsZkxpc2Kh0zi3NGwA/FUbetAS9khWxYesxT4s=";
     }
 ];
  home.file.".vscode/argv.json".text = ''
// This configuration file allows you to pass permanent command line arguments to VS Code.
// Only a subset of arguments is currently supported to reduce the likelihood of breaking
// the installation.
//
// PLEASE DO NOT CHANGE WITHOUT UNDERSTANDING THE IMPACT
//
// NOTE: Changing this file requires a restart of VS Code.
{
	// Use software rendering instead of hardware accelerated rendering.
	// This can help in cases where you see rendering issues in VS Code.
	// "disable-hardware-acceleration": true,

	// Allows to disable crash reporting.
	// Should restart the app if the value is changed.
	"enable-crash-reporter": true,

	// Unique id used for correlating crash reports sent from this instance.
	// Do not edit this value.
	"crash-reporter-id": "29226fb3-ac7d-4d37-a854-717dd89b19c0",
        "password-store":"gnome-libsecret",
}
  '';
}
