{pkgs, ...}: {
  plugins = {
    # HTML and JSX Tags auto updater
    ts-autotag.enable = true;
    # Vim CSS plugin to display color
    nvim-colorizer.enable = true;

    # Better TODO comments.
    todo-comments.enable = true;
  };

  extraPlugins = with pkgs; [
    # You'll need to install nerdfont symbol font.
    vimPlugins.nvim-web-devicons
  ];
}
