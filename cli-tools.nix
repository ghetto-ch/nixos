{ pkgs, ... }:
{
  home.packages = with pkgs; [
    fd
    ripgrep
    bat
    gcc
    gnumake
    television
    hyperfine
    lazygit
    eza
    tmux
  ];

  programs.nh = {
    enable = true;
    clean.enable = true;
    clean.extraArgs = "--keep-since 4d --keep 3";
    flake = "$HOME/nixos"; # sets NH_OS_FLAKE variable for you
  };

}
