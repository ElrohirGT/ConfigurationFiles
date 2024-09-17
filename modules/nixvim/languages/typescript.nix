{pkgs, ...}: {
  plugins.lsp = {
    servers.ts-ls.enable = true;
  };

  plugins.treesitter = {
    grammarPackages = with pkgs.vimPlugins.nvim-treesitter.builtGrammars; [
      typescript
    ];
  };
}
