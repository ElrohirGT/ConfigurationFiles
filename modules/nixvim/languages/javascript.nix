{pkgs, ...}: {
  plugins.lsp = {
    servers.ts_ls.enable = true;
  };

  plugins.treesitter = {
    grammarPackages = with pkgs.vimPlugins.nvim-treesitter.builtGrammars; [
      javascript
    ];
  };
}
