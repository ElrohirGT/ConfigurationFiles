{pkgs, ...}: let
  fasterPlugin = import ../plugins/faster.plugin.nix pkgs;
  golfPlugin = import ../plugins/vimgolf.plugin.nix pkgs;
in {
  extraPlugins = [
    # You'll need to install nerdfont symbol font.
    pkgs.vimPlugins.nvim-web-devicons
    pkgs.vimPlugins.dropbar-nvim
    fasterPlugin.package
    golfPlugin.package
  ];

  extraConfigLua = fasterPlugin.luaConfig;
}
