{pkgs, ...}: {
  lsp = {
    servers.arduino_language_server.enable = true;
  };

  plugins.treesitter = {
    grammarPackages = with pkgs.vimPlugins.nvim-treesitter.builtGrammars; [
      cpp
    ];
  };
}
