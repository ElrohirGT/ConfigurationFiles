{pkgs, ...}: {
  plugins.lsp = {
    servers.gleam = {
      enable = true;
      package = null;
    };
  };

  plugins.treesitter = {
    grammarPackages = with pkgs.vimPlugins.nvim-treesitter.builtGrammars; [
      gleam
    ];
  };
}
