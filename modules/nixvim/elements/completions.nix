{
  lib,
  config,
  options,
  ...
}: {
  config = {
    plugins = {
      lspkind.enable = true;

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
            "<C-y>" = "cmp.mapping.confirm({ select = true })";
          };
        };
      };
    };
  };
}
