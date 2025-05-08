{pkgs, ...}: {
  # Starlark is used for Tilt in its Tiltfile!
  plugins.lsp = {
    servers.starpls.enable = true;
  };

  plugins.treesitter = {
    grammarPackages = with pkgs.vimPlugins.nvim-treesitter.builtGrammars; [
      starlark
    ];
  };
}
