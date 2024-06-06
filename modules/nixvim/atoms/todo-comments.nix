{
  # Better TODO comments.
  plugins.todo-comments.enable = true;
  keymaps = [
    {
      mode = "n";
      key = "<leader>xt";
      action = ":TodoQuickFix<CR>";
      options = {
        desc = "Toogle TODO and other tasks comments in quick fix view";
      };
    }
    {
      mode = "n";
      key = "<leader>ft";
      action = ":TodoTelescope<CR>";
      options = {
        desc = "Toggle TODO and other tasks comments in telescope";
      };
    }
  ];
}
