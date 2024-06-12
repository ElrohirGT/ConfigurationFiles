{pkgs, ...}: {
  plugins.lsp = {
    servers.nixd.enable = true;
  };

  plugins.treesitter = {
    grammarPackages = with pkgs.vimPlugins.nvim-treesitter.builtGrammars; [
      nix
    ];
  };
}
