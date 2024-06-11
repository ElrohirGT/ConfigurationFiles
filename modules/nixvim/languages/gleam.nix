{pkgs, ...}: {
  plugins.lsp = {
    servers.gleam.enable = true;
  };

  plugins.treesitter = {
    grammarPackages = with pkgs.vimPlugins.nvim-treesitter.builtGrammars; [
      gleam
    ];
  };
}
