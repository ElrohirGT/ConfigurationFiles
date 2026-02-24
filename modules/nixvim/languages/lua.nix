{pkgs, ...}: {
  lsp = {
    servers = {
      lua_ls.enable = true;
    };
  };

  plugins.treesitter = {
    grammarPackages = with pkgs.vimPlugins.nvim-treesitter.builtGrammars; [
      lua
    ];
  };
}
