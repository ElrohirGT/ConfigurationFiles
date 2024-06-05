{
  # Manage files in neovim a buffer
  plugins.oil.enable = true;
  keymaps = [
    {
      mode = "n";
      key = "<leader>e";
      action = ":Oil<CR>";
      options = {
        desc = "Toggle Oil";
      };
    }
  ];
}
