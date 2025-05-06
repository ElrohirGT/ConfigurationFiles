{
  plugins = {
    lspkind.enable = true;

    # Completions framework and sources
    cmp = {
      enable = true;

      # Auto installs sources listed below if recognized by nixvim.
      autoEnableSources = true;
      settings = {
        mapping = {
          "<C-d>" = "cmp.mapping.scroll_docs(-4)";
          "<C-f>" = "cmp.mapping.scroll_docs(4)";

          # Manually trigger a completion from nvim-cmp
          "<C-Space>" = "cmp.mapping.complete()";
          "<C-e>" = "cmp.mapping.close()";
          "<C-n>" = "cmp.mapping.select_next_item()";
          "<C-p>" = "cmp.mapping.select_prev_item()";
          "<C-y>" = "cmp.mapping.confirm({ select = true })";
        };
        sources = [
          # Snippets on top
          {name = "luasnip";}
          # LSP and Treessitter later
          {name = "nvim_lsp";}
          {name = "nvim_lsp_signature_help";}

          {name = "path";}
          # {name = "calc";}
          {name = "buffer";}

          # Completion for neovim Lua API.
          {name = "nvim_lua";}
        ];
      };
    };
  };
}
