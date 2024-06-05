{
    plugins = {
        # HTML and JSX Tags auto updater
        ts-autotag.enable = true;
      # Vim CSS plugin to display color
      nvim-colorizer.enable = true;

        # Better TODO comments.
        todo-comments.enable = true;
    };

    extraPlugins = with pkgs; [
      vimPlugins.nvim-web-devicons
    ];
}