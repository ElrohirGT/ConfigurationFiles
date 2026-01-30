{pkgs, ...}: {
  # Enable treesitter with a bunch of parsers by default
  plugins.treesitter = {
    enable = true;
    folding.enable = true;
    grammarPackages = with pkgs.vimPlugins.nvim-treesitter.builtGrammars; [
      # General
      regex
      proto
      bash
      sql
      latex
      mermaid

      # C
      c
      cpp

      # Zig
      zig

      # Neovim config
      lua
      vimdoc

      # configs
      yaml
      json

      # Rust
      rust
      toml
    ];

    settings = {
      highlight.enable = true;
    };
  };

  extraConfigVim = ''
    set nofoldenable " Disable fold on startup
  '';
}
