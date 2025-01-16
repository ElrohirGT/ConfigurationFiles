{
  plugins.markdown-preview = {
    enable = true;
    settings = {
      autoStart = false;
      theme = "dark";
      browser = "firefox";
    };
    #        browserFunc = ''
    #          function OpenMarkdownPreview (url)
    #          	execute "silent ! vimb " . a:url . " &"
    #          endfunction
    #        '';
  };

  keymaps = [
    # Markdown preview controls
    {
      mode = "n";
      key = "<leader>ms";
      action = ":MarkdownPreviewStop<CR>";
    }
    {
      mode = "n";
      key = "<leader>mp";
      action = ":MarkdownPreview<CR>";
    }
    # Enable/Disable wordwrap
    {
      key = "<leader>we";
      action = ":set wrap<CR>";
      mode = "n";
    }
    {
      key = "<leader>ws";
      action = ":set nowrap<CR>";
      mode = "n";
    }
    # Change spelling
    {
      key = "<leader>ls";
      action = ":set spell spelllang=es_gt<CR>";
      mode = "n";
    }
    {
      key = "<leader>le";
      action = ":set spell spelllang=en_us<CR>";
      mode = "n";
    }
  ];
}
