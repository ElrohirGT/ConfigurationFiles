{pkgs, ...}: {
  plugins = {
    # Snippet engine
    luasnip.enable = true;
  };
  extraPlugins = with pkgs; [
    # You'll need to install nerdfont symbol font.
    vimPlugins.nvim-web-devicons
    vimPlugins.dropbar-nvim
  ];
}
