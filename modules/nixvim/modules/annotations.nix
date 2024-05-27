{
  plugins.neogen = {
    enable = true;
    enablePlaceholders = true;
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
