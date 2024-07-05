{pkgs, ...}: {
  extraPlugins = with pkgs; [
    # You'll need to install nerdfont symbol font.
    vimPlugins.nvim-web-devicons
    vimPlugins.dropbar-nvim
  ];
}
