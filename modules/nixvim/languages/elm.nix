{pkgs, ...}: {
  plugins.lsp = {
    servers.elmls.enable = true;
  };

  plugins.treesitter = {
    grammarPackages = with pkgs.vimPlugins.nvim-treesitter.builtGrammars; [
      elm
    ];
  };
}
