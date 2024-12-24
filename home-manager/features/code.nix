{
  config,
  pkgs,
  ...
}:
{
  programs.vscode.enable = true;
  programs.userSettings = {
    "files.autoSave" = "afterDelay",
    "workbench.colorTheme" = "GitHub Dark Colorblind (Beta)"
  };
  programs.vscode.extensions = [
    pkgs.vscode-extensions.github.github-vscode-theme
  ];
}