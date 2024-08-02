{
  # Better error messages
  plugins.trouble.enable = true;
  keymaps = [
    # Error panes logic
    {
      mode = "n";
      key = "<leader>xx";
      action = "<cmd>Trouble diagnostics toggle<cr>";
    }
    {
      mode = "n";
      key = "<leader>xq";
      action = "<cmd>Trouble qflist toggle<cr>";
    }
  ];
}
