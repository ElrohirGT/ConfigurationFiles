{pkgs, ...}: {
  plugins.lsp = {
    servers.html.enable = true;
  };

  plugins.treesitter = {
    grammarPackages = with pkgs.vimPlugins.nvim-treesitter.builtGrammars; [
      html
    ];
  };

  # HTML and JSX Tags auto updater
  plugins.ts-autotag.enable = true;
}
