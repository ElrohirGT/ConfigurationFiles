{pkgs, ...}: {
  plugins.zig.enable = true;

  plugins.lsp = {
    servers.zls.enable = true;
  };

  plugins.treesitter = {
    grammarPackages = with pkgs.vimPlugins.nvim-treesitter.builtGrammars; [zig];
  };
}
