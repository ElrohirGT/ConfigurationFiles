{pkgs, ...}: {
  plugins.lsp.servers.pylsp.enable = true;

  plugins.treesitter = {
    grammarPackages = with pkgs.vimPlugins.nvim-treesitter.builtGrammars; [
      python
    ];
  };
}
