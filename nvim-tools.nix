{ pkgs, ... }:
{
  home.packages = with pkgs; [
    tree-sitter

    # Language servers
    lua-language-server
    nil
    clang-tools
    ty
    bash-language-server
    fish-lsp
    gopls

    # Formatters
    stylua
    nixfmt
    nixpkgs-fmt
    astyle
    ruff
    shfmt

    # Linters
    vale
    #ruff see formatters
    shellharden
  ];
}
