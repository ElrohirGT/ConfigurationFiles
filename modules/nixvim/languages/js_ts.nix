{pkgs, ...}: {
  lsp = {
    servers.ts_ls.enable = true;
    servers.biome.enable = true;
  };

  plugins.treesitter = {
    grammarPackages = with pkgs.vimPlugins.nvim-treesitter.builtGrammars; [
      javascript
      typescript
    ];
  };
}
