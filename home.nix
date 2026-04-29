{ config, pkgs, inputs, ... }:

let
	dotfiles = "${config.home.homeDirectory}/dotfiles/.config";
	create_symlink = path: config.lib.file.mkOutOfStoreSymlink path;

	configs = {
		niri = "niri";
		fish = "fish";
		tmux = "tmux";
		nvim = "nvim";
	};

in

{
	home.username = "ghetto";
	home.homeDirectory = "/home/ghetto";
	home.stateVersion = "25.11";

	home.sessionPath = [
		"$HOME/.local/bin"
	];

	programs.bash.enable = true;
	# programs.tmux.enable = true;
	# programs.fish.enable = true;
	#
	programs.git = {
		enable = true;
		userName = "ghetto";
		userEmail = "ghetto.ch@gmail.com";
	};

	programs.lazygit = {
		enable = true;
		shellWrapperName = "lg";
	};

	home.packages = with pkgs; [
		neovim
		ripgrep
		nil
		nixpkgs-fmt
		gcc
		fd
		alacritty
		fish
		tmux
		tree-sitter
		gnumake
		television
	];

	xdg.configFile = builtins.mapAttrs (name: subpath: {
		source = create_symlink "${dotfiles}/${subpath}";
		recursive = true;

	}) configs;

}

