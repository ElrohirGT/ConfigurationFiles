{
  imports = [
    # Big elements that use multiple plugins.
    ./elements/basic.nix
    ./elements/completions.nix
    ./elements/language-servers.nix
    ./elements/autoformatting.nix
    ./elements/goodies.nix

    # Single plugins configuration
    ./atoms/gitblame.nix
    ./atoms/highlight-on-yank.nix
    ./atoms/inc-rename.nix
    ./atoms/luasnip.nix
    ./atoms/markdown-preview.nix
    ./atoms/neogen.nix
    ./atoms/notify.nix
    ./atoms/oil.nix
    ./atoms/otter.nix
    ./atoms/telescope.nix
    ./atoms/todo-comments.nix
    ./atoms/treesitter.nix
    ./atoms/trouble.nix

    # Languages
    ./languages/go.nix
    ./languages/markdown.nix
    ./languages/nix.nix
    ./languages/typescript.nix
    ./languages/javascript.nix
  ];
}
