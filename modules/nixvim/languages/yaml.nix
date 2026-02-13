{pkgs, ...}: {
  plugins.lsp = {
    servers.yamlls.enable = true;
  };

  plugins.treesitter = {
    grammarPackages = with pkgs.vimPlugins.nvim-treesitter.builtGrammars; [
      yaml
    ];
  };
}
