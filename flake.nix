{
	description = "NixOS - gondolin";

	inputs = {
		nixpkgs.url = "nixpkgs/nixos-25.11";
		nixpkgs-unstable.url = "nixpkgs/nixos-unstable";

		home-manager = {
			url = "github:nix-community/home-manager/release-25.11";
			inputs.nixpkgs.follows = "nixpkgs";
		};

		dms = {
			url = "github:AvengeMedia//DankMaterialShell/stable";
			inputs.nixpkgs-unstable.follows = "nixpkgs-unstable";
		};

		dgop = {
			url = "github:AvengeMedia/dgop";
			inputs.nixpkgs-unstable.follows = "nixpkgs-unstable";
		};

	};

	outputs = { self, nixpkgs, nixpkgs-unstable, home-manager, ... }@inputs: {
		nixosConfigurations.gondolin = nixpkgs.lib.nixosSystem {
			system = "x86_64-linux";
			modules = [
				./configuration.nix
					home-manager.nixosModules.home-manager
					{
						home-manager = {
							useGlobalPkgs = true;
							useUserPackages = true;
							users.ghetto = import ./home.nix;
							backupFileExtension = "bck";
							extraSpecialArgs = { inherit inputs; };
						};
					}
			];
		};
	};
}
