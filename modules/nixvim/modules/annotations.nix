{
  plugins.neogen = {
    enable = true;
    enablePlaceHolders = true;
    snippetEngine = "luasnip";
  };

  keymaps = [
    # Annotate the closest function
    {
      mode = "n";
      key = "<leader>af";
      action = ":Neogen func";
    }
  ];
}
