{ pkgs, ... }:
{
  home.packages = with pkgs; [
    alacritty
    pcmanfm
    firefox
    chromium
    bitwarden-desktop
  ];
}
