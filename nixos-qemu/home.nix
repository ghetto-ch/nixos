{ config, ... }:
let
  dotfiles = "${config.home.homeDirectory}/dotfiles/.config";
  createSymlink = path: config.lib.file.mkOutOfStoreSymlink path;

  configs = {
    fish = { subpath = "fish"; recursive = true; };
    nvim = { subpath = "nvim"; recursive = true; };
    git = { subpath = "git"; recursive = true; };
    stylua = { subpath = "stylua"; recursive = true; };
    "tmux/tmux.conf" = { subpath = "tmux/tmux.conf"; recursive = false; };

  };

in

{
  imports = [
    ../cli-tools.nix
    ../nvim-tools.nix
    ../ai-tools.nix

  ];
  # Home Manager needs a bit of information about you and the
  # paths it should manage.
  home.username = "nixos";
  home.homeDirectory = "/home/nixos";

  home.sessionPath = [
    "$HOME/.local/bin"
  ];

  xdg.configFile = builtins.mapAttrs
    (name: cfg: {
      source = createSymlink "${dotfiles}/${cfg.subpath}";
      recursive = cfg.recursive;
    })
    configs;

  # This value determines the Home Manager release that your
  # configuration is compatible with. This helps avoid breakage
  # when a new Home Manager release introduces backwards
  # incompatible changes.
  #
  # You can update Home Manager without changing this value. See
  # the Home Manager release notes for a list of state version
  # changes in each release.
  home.stateVersion = "25.05";

  # Let Home Manager install and manage itself.
  programs.home-manager.enable = true;
}
