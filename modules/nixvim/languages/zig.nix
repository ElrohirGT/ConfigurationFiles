{pkgs, ...}: {
  plugins.zig.enable = true;

  lsp = {
    servers.zls.enable = true;
  };

  plugins.treesitter = {
    grammarPackages = with pkgs.vimPlugins.nvim-treesitter.builtGrammars; [zig];
  };
}
