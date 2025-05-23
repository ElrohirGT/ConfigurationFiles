{
  plugins.gitblame.enable = true;
  keymaps = [
    {
      mode = "n";
      key = "<leader>tg";
      action = ":GitBlameToggle<CR>";
      options = {
        desc = "Toggles the git blame virtual text";
      };
    }
  ];
}
