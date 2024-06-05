{
  imports = [
    # Big elements that use multiple plugins.
    ./elements/basic.nix
    ./elements/completions.nix

    # Single plugins configuration
    ./atoms/treesitter.nix
    ./atoms/oil.nix
    ./atoms/telescope.nix
    ./atoms/highlight-on-yank.nix
  ];
}
