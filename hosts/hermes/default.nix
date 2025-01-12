{
  nixpkgs,
  inputs,
  outputs,
  ...
}: let
  home-manager = inputs.home-manager;
  user = "liberontissauri";
in
  nixpkgs.lib.nixosSystem {
    system = "aarch64-linux";
    specialArgs = {inherit inputs outputs user;};
    modules = [
      ./configuration.nix
      home-manager.nixosModules.home-manager
      {
	home-manager.backupFileExtension = "backup3";
        home-manager.useUserPackages = true;
        home-manager.users.liberontissauri.imports = [
          ./home.nix
        ];
        home-manager.extraSpecialArgs = {inherit inputs outputs user;};
      }
    ];
  }
