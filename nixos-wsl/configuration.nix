{ pkgs, ... }:

{
  imports = [
    # ...
  ];

  wsl.enable = true;
  wsl.defaultUser = "nixos";

  nixpkgs.config.allowUnfree = true;

  nix.settings.experimental-features = [
    "nix-command"
    "flakes"
  ];

  environment.systemPackages = with pkgs; [
    git
    wl-clipboard
  ];

  programs.neovim = {
    enable = true;
    defaultEditor = true;
  };

  programs.fish.enable = true;
  users.users.nixos.shell = pkgs.fish;

  # Unset system aliases so that I can use eza instead of standard ls
  environment.shellAliases = {
    ls = null;
    ll = null;
    l = null;
  };

  services.openssh = {
    enable = true;
    settings = {
      PasswordAuthentication = false;
      PermitRootLogin = "no";
    };
  };

  # This value determines the NixOS release from which the default
  # settings for stateful data, like file locations and database versions
  # on your system were taken. It's perfectly fine and recommended to leave
  # this value at the release version of the first install of this system.
  # Before changing this value read the documentation for this option
  # (e.g. man configuration.nix or on https://nixos.org/nixos/options.html).
  system.stateVersion = "25.11"; # Did you read the comment?
}
