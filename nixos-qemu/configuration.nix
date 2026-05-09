{ pkgs, ... }:

{
	imports =
		[ # Include the results of the hardware scan.
		./hardware-configuration.nix
		];

	boot.loader.systemd-boot.enable = true;
	boot.loader.efi.canTouchEfiVariables = true;

	networking.hostName = "nixos-qemu";
	networking.networkmanager.enable = true;

	nixpkgs.config.allowUnfree = true;

  nix.settings.experimental-features = [
    "nix-command"
    "flakes"
  ];

	time.timeZone = "Europe/Zurich";

	users.users.ghetto = {
		isNormalUser = true;
		extraGroups = [ "wheel" ];
		openssh.authorizedKeys.keys = [
			"ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAIImI+EAQDenPCxUU9byjgRZWclC12SOTqsjo4PLuqqHm ghetto.ch@gmail.com"
		];
    shell = pkgs.fish;
	};

	environment.systemPackages = with pkgs; [
    git
    wl-clipboard
	];

  programs.neovim = {
    enable = true;
    defaultEditor = true;
  };

  programs.fish.enable = true;

  # Unset system aliases so that I can use eza instead of standard ls
  environment.shellAliases = {
    ls = null;
    ll = null;
    l = null;
  };

  # Enable the OpenSSH daemon.
  services.openssh = {
    enable = true;
    settings = {
      PasswordAuthentication = false;
      PermitRootLogin = "no";
    };
  };

  # QEMU guest agent
  services.qemuGuest.enable = true;
  # SPICE agent — gestisce clipboard e resize schermo
  services.spice-vdagentd.enable = true;

	system.stateVersion = "25.11";

}
