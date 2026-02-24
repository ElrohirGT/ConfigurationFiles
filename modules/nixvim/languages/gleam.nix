{pkgs, ...}: {
  lsp = {
    servers.gleam = {
      enable = true;
      package = null; # Inherit gleamls from the local setup
    };
  };

  plugins.treesitter = {
    grammarPackages = with pkgs.vimPlugins.nvim-treesitter.builtGrammars; [
      gleam
    ];
  };
}
