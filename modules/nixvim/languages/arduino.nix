{pkgs, ...}: {
  lsp = {
    servers.arduino_language_server.enable = true;
  };

  extraPlugins = [
    pkgs.arduino-cli
  ];

  plugins.treesitter = {
    grammarPackages = with pkgs.vimPlugins.nvim-treesitter.builtGrammars; [
      cpp
    ];
  };
}
