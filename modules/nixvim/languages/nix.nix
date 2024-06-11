{pkgs, ...}: {
  plugins.lsp = {
    servers.nil_ls.enable = true;
  };

  plugins.treesitter = {
    grammarPackages = with pkgs.vimPlugins.nvim-treesitter.builtGrammars; [
      nix
    ];
  };
}
