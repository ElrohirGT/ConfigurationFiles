{
  plugins.neogen = {
    enable = true;
    settings = {
      enablePlaceholders = true;
      snippetEngine = "luasnip";
    };
  };

  keymaps = [
    # Annotate the closest function
    {
      mode = "n";
      key = "<leader>af";
      action = ":Neogen func<CR>";
    }
  ];
}
