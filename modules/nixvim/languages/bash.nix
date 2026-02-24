{pkgs, ...}: {
  lsp = {
    servers.bashls.enable = true;
  };

  plugins.treesitter = {
    grammarPackages = with pkgs.vimPlugins.nvim-treesitter.builtGrammars; [
      bash
    ];
  };
}
