{pkgs, ...}: {
  # lsp = {
  #   servers.yamlls.enable = true;
  # };

  plugins.typst-vim.enable = true;
  plugins.typst-preview.enable = true;

  plugins.treesitter = {
    grammarPackages = with pkgs.vimPlugins.nvim-treesitter.builtGrammars; [
      typst
    ];
  };
}
