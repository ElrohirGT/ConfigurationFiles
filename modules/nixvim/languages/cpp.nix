{pkgs, ...}: {
  lsp = {
    servers.clangd.enable = true;
    servers.cmake.enable = true;
  };

  plugins.treesitter = {
    grammarPackages = with pkgs.vimPlugins.nvim-treesitter.builtGrammars; [
      cpp
      cmake
    ];
  };
}
