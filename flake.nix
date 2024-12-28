{
  description = "Your new nix config";

  inputs = {
    # Nixpkgs
    nixpkgs.url = "github:nixos/nixpkgs/nixos-24.11";
    firefox-addons = {
      url = "gitlab:rycee/nur-expressions?dir=pkgs/firefox-addons";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    # Home manager
    home-manager.url = "github:nix-community/home-manager/release-24.11";
    home-manager.inputs.nixpkgs.follows = "nixpkgs";

    stylix.url = "github:danth/stylix";

    impermanence.url = "github:nix-community/impermanence";

    disko = {
      url = "github:nix-community/disko";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    sddm-sugar-candy-nix = {
      url = "gitlab:Zhaith-Izaliel/sddm-sugar-candy-nix";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    nvim-config = {
      url = "github:Liberontissauri/nix-nvim-config";
    };
  };

  outputs = {
    self,
    nixpkgs,
    home-manager,
    stylix,
    impermanence,
    disko,
    sddm-sugar-candy-nix,
    nvim-config,
    ...
  } @ inputs: let
    inherit (self) outputs;
  in {
    nixosConfigurations = {
      lib-desktop = nixpkgs.lib.nixosSystem {
        specialArgs = {inherit inputs outputs;};
        # > Our main nixos configuration file <
        modules = [
          disko.nixosModules.default
          (import ./nixos/disko.nix {device = "/dev/sda";})
          impermanence.nixosModules.impermanence
          sddm-sugar-candy-nix.nixosModules.default
          ./nixos/configuration.nix
          home-manager.nixosModules.home-manager
          {
            home-manager.useUserPackages = true;
            home-manager.users.liberontissauri.imports = [
              stylix.homeManagerModules.stylix
              impermanence.homeManagerModules.impermanence
              ./home-manager/home.nix
            ];
            home-manager.extraSpecialArgs = {inherit inputs;};
            home-manager.backupFileExtension = "bk";

            # Optionally, use home-manager.extraSpecialArgs to pass
            # arguments to home.nix
          }
        ];
      };
    };

    # Standalone home-manager configuration entrypoint
    # Available through 'home-manager --flake .#your-username@your-hostname'
    homeConfigurations = {
      home-manager.backupFileExtension = "bk";
      "liberontissauri@lib-desktop" = home-manager.lib.homeManagerConfiguration {
        pkgs = nixpkgs.legacyPackages.x86_64-linux; # Home-manager requires 'pkgs' instance
        extraSpecialArgs = {inherit inputs outputs;};
        # > Our main home-manager configuration file <
        modules = [
          stylix.homeManagerModules.stylix
          ./home-manager/home.nix
        ];
      };
    };
  };
}
