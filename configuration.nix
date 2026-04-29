{ config, lib, pkgs, ... }:

{
	imports =
		[ # Include the results of the hardware scan.
		./hardware-configuration.nix
		];

	boot.loader.systemd-boot.enable = true;
	boot.loader.efi.canTouchEfiVariables = true;

	networking.hostName = "gondolin";
	networking.networkmanager.enable = true;

	nixpkgs.config.allowUnfree = true;

	time.timeZone = "Europe/Zurich";

	users.users.ghetto = {
		isNormalUser = true;
		extraGroups = [ "wheel" ];
		packages = with pkgs; [
			tree
		];
		openssh.authorizedKeys.keys = [
			"ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAIImI+EAQDenPCxUU9byjgRZWclC12SOTqsjo4PLuqqHm ghetto.ch@gmail.com"
		];
	};

	programs.firefox.enable = true;
	programs.niri.enable = true;
	programs.dms-shell = {
		enable = true;
		enableSystemMonitoring = true;
	};

	virtualisation.vmware.guest.enable = true;

	environment.systemPackages = with pkgs; [
		vim
		wget
		alacritty
		#ovftool
	];
	#ovftool.override = { acceptBroadcomEula = true; };

#fonts.packages = with pkgs; [
#	nerd-fonts.hack-mono
#];

# Enable the OpenSSH daemon.
services.openssh.enable = true;

	nix.settings.experimental-features = [ "nix-command" "flakes" ];
	system.stateVersion = "25.11";

}
