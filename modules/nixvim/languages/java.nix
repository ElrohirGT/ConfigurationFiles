{pkgs, ...}: {
  lsp = {
    servers.java_language_server.enable = true;
  };

  plugins.treesitter = {
    grammarPackages = with pkgs.vimPlugins.nvim-treesitter.builtGrammars; [
      java
    ];
  };
}
