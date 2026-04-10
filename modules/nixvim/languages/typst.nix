{pkgs, ...}: {
  lsp = {
    servers.tinymist.enable = true;
  };

  plugins.typst-vim.enable = true;
  plugins.typst-preview = {
    enable = true;
    settings = {
      open_cmd = "firefox %s -class typst-preview";
      # dependencies_bin = {
      #   tinymist = "tinymist";
      #   websocat = "websocat";
      # };
    };
  };

  plugins.treesitter = {
    grammarPackages = with pkgs.vimPlugins.nvim-treesitter.builtGrammars; [
      typst
    ];
  };
}
