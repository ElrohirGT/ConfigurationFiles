{pkgs, ...}: {
  plugins.lsp = {
    servers.ols.enable = true;
  };

  plugins.treesitter = {
    grammarPackages = with pkgs.vimPlugins.nvim-treesitter.builtGrammars; [
      odin
    ];
  };
}
