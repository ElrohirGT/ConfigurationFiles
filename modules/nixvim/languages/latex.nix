{
  # LaTex setup
  plugins.lsp = {
    servers.texlab.enable = true;
  };

  plugins.vimtex = {
    enable = true;
    # Dont install any package
    # since texlive should be installed by the sistem.
    texlivePackage = null;
  };
}
