{pkgs, ...}: {
  plugins.java.enable = true;

  plugins.treesitter = {
    grammarPackages = with pkgs.vimPlugins.nvim-treesitter.builtGrammars; [
      java
    ];
  };
}
