{
  plugins.gitblame.enable = true;
  keymaps = [
    {
      mode = "n";
      key = "<leader>g";
      action = ":GitBlameToggle";
      options = {
        desc = "Toggles the git blame virtual text";
      };
    }
  ];
}
