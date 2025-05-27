{pkgs, ...}: {
  plugins.lsp = {
    servers.nim_langserver.enable = true;
  };

  plugins.treesitter = {
    grammarPackages = with pkgs.vimPlugins.nvim-treesitter.builtGrammars; [
      nim
    ];
  };
}
