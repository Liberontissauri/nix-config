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
    specialArgs = {inherit inputs outputs user;};
    modules = [
      ./configuration.nix
      home-manager.nixosModules.home-manager
      {
        home-manager.useUserPackages = true;
        home-manager.users.liberontissauri.imports = [
          ./home.nix
        ];
        home-manager.extraSpecialArgs = {inherit inputs outputs user;};
        home-manager.backupFileExtension = "bk";
      }
    ];
  }
