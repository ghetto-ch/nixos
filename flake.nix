{
	description = "NixOS - gondolin";

	inputs = {
		nixpkgs.url = "nixpkgs/nixos-unstable";

		home-manager = {
			url = "github:nix-community/home-manager/master";
			inputs.nixpkgs.follows = "nixpkgs";
		};

	};

	outputs = { self, nixpkgs, home-manager, ... }@inputs: {
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
