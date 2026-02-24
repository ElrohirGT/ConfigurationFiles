{pkgs, ...}: {
  plugins = {
    rustaceanvim.enable = true;
  };

  plugins.treesitter = {
    grammarPackages = with pkgs.vimPlugins.nvim-treesitter.builtGrammars; [
      rust
    ];
  };
}
