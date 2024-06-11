{pkgs, ...}: {
  imports = [../atoms/markdown-preview.nix];

  plugins.lsp = {
    servers.marksman.enable = true;
  };

  plugins.treesitter = {
    grammarPackages = with pkgs.vimPlugins.nvim-treesitter.builtGrammars; [
      markdown
    ];
  };
}
