{pkgs, ...}: {
  plugins.lsp = {
    servers.gopls.enable = true;
  };

  plugins.treesitter = {
    grammarPackages = with pkgs.vimPlugins.nvim-treesitter.builtGrammars; [
      go
    ];
  };
}
