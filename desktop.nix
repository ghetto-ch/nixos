{ pkgs, ... }:
{
  home.packages = with pkgs; [
    dms-shell
  ];

  programs.niri.enable = true;

  services.displayManager.dms-greeter = {
    enable = true;
    compositor.name = "niri";
  };

}

