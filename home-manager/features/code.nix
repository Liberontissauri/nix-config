{
  config,
  pkgs,
  ...
}:
{
  programs.vscode.enable = true;
  programs.vscode.userSettings = {
    "files.autoSave" = "afterDelay";
    "workbench.colorTheme" = "GitHub Dark Colorblind (Beta)";
  };
  programs.vscode.extensions = [
    pkgs.vscode-extensions.github.github-vscode-theme
    pkgs.vscode-extensions.github.copilot
  ];
}