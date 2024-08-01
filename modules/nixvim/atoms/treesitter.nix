{pkgs, ...}: {
  # Enable treesitter with a bunch of parsers by default
  plugins.treesitter = {
    enable = true;
    folding = true;
    grammarPackages = with pkgs.vimPlugins.nvim-treesitter.builtGrammars; [
      # General
      regex
      python
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

  keymaps = [
    {
      mode = "n";
      key = "<leader>z";
      action = ":set foldmethod=expr<CR> :set foldexpr=nvim_treesitter#foldexpr()<CR>";
      options = {
        desc = "Set folding method to use indentation";
      };
    }
  ];
}
