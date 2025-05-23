{
  # Icons needed for trouble
  plugins.web-devicons.enable = true;

  # Better error messages
  plugins.trouble.enable = true;
  keymaps = [
    # Error panes logic
    {
      mode = "n";
      key = "<leader>xx";
      action = "<cmd>Trouble diagnostics toggle<cr>";
      options = {
        desc = "Toggle Trouble diagnostics.";
      };
    }
    {
      mode = "n";
      key = "<leader>xq";
      action = "<cmd>Trouble qflist toggle<cr>";
      options = {
        desc = "Toggle Trouble quickfix list";
      };
    }
  ];
}
