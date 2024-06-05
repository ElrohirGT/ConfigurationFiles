{
  plugins = {
    # Notifications
    notify.enable = true;
  };

  # Override default notify to use installed notify plugin.
  extraConfigLua = ''
    vim.notify = require("notify")
  '';
}
