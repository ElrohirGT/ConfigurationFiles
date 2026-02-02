{pkgs, ...}: {
  plugins.lsp = {
    servers.dhall_lsp_server.enable = true;
  };

  plugins.treesitter = {
    grammarPackages = with pkgs.vimPlugins.nvim-treesitter.builtGrammars; [
      dhall
    ];
  };
}
