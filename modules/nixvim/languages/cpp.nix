{pkgs, ...}: {
  plugins.lsp = {
    servers.ccls.enable = true;
  };

  plugins.treesitter = {
    grammarPackages = with pkgs.vimPlugins.nvim-treesitter.builtGrammars; [
      cpp
    ];
  };
}
