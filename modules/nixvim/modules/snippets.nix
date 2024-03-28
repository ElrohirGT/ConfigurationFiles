{
  plugins.luasnip = {
    enable = true;
    extraConfig = {
      enable_autosnippets = true;
      store_selection_keys = "<Tab>";
    };
  };

  # Setting up the completion engine to use luasnip
  plugins.cmp.settings.snippet.expand = ''function(args) require('luasnip').lsp_expand(args.body) end'';
}
