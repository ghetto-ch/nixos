{ pkgs, ... }:
{
  home.packages = with pkgs; [
    # ollama
    aichat
    opencode
  ];

  services.ollama.enable = true;
  # programs.opencode.enable = true;
}
