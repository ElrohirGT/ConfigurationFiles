{pkgs, ...}: {
  plugins.lsp = {
    servers.cssls.enable = true;
  };

  plugins.treesitter = {
    grammarPackages = with pkgs.vimPlugins.nvim-treesitter.builtGrammars; [
      css
    ];
  };

  # Vim CSS plugin to display color
  plugins.colorizer.enable = true;
}
