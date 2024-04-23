{
  plugins = {
    # Notifications
    notify.enable = true;
  };

  # Override default notify to use installed notify plugin.
  extraConfig = ''
    vim.notify = require("notify")
  '';
}
