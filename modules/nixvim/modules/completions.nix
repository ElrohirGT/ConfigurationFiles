{
  lib,
  config,
  options,
  ...
}: {
  options.completions.isDefault = lib.mkOption {
    type = lib.types.nullOr lib.types.bool;
    description = "If set to false, some functionality will be disabled to save disk space.";
    default = true;
  };

  config = {
    plugins = {
      # Completions framework and sources
      cmp = {
        enable = true;

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
            "<CR>" = "cmp.mapping.confirm({ select = true })";
          };
          formatting.format = ''
            function(entry, item)
             local menu_icon ={
              nvim_lsp = "λ",
              vsnip = "⋗",
              buffer = "Ω",
              path = "🖫",
             }
             item.menu = menu_icon[entry.source.name]
             return item
            end
          '';
          sources =
            (
              if config.completions.isDefault
              then [
                {name = "nvim_lsp";}
                {name = "treesitter";}
                {name = "nvim_lsp_signature_help";}
                {name = "nvim_lua";}
                {name = "luasnip";}
              ]
              else []
            )
            ++ [
              {name = "path";}
              {name = "calc";}
              {name = "buffer";}
            ];
        };
      };
    };
  };
}
