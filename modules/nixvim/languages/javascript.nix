{pkgs, ...}: {
  plugins.lsp = {
    servers.tsserver.enable = true;
  };

  plugins.treesitter = {
    grammarPackages = with pkgs.vimPlugins.nvim-treesitter.builtGrammars; [
      javascript
    ];
  };
}
