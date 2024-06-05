{
  # Rename incrementally with LSP support
  plugins.inc-rename.enable = true;
  keymaps = [
    {
      mode = "n";
      key = "<leader>rn";
      action = ":IncRename ";
      options = {
        desc = "Rename symbols using IncRename";
      };
    }
  ];
}
