{pkgs, ...}: {
  lsp = {
    servers.nixd.enable = true;
    servers.statix.enable = true;
  };

  plugins.treesitter = {
    grammarPackages = with pkgs.vimPlugins.nvim-treesitter.builtGrammars; [
      nix
    ];
  };
}
