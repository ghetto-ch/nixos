{ config, pkgs, inputs, ... }:

let
	dotfiles = "${config.home.homeDirectory}/dotfiles/.config";
	create_symlink = path: config.lib.file.mkOutOfStoreSymlink path;

	configs = {
		niri = "niri";

	};

	pkgs-unstable = import inputs.nixpkgs-unstable {
		system = pkgs.system;
		config.allowUnfree = true;
	};

in

{
	home.username = "ghetto";
	home.homeDirectory = "/home/ghetto";
	home.stateVersion = "25.11";

	programs.bash.enable = true;
	programs.git = {
		enable = true;
		userName = "ghetto";
		userEmail = "ghetto.ch@gmail.com";
	};

	home.packages = with pkgs; [
		neovim
		ripgrep
		nil
		nixpkgs-fmt
		gcc
		fd
		alacritty
	];

	xdg.configFile = builtins.mapAttrs (name: subpath: {
		source = create_symlink "${dotfiles}/${subpath}";
		recursive = true;

	}) configs;

	imports = [
		inputs.dms.homeModules.dank-material-shell
	];

	programs.dank-material-shell = {
		enable = true;
		enableSystemMonitoring = true;
		dgop.package = inputs.dgop.packages.${pkgs.system}.default;
	};

}

