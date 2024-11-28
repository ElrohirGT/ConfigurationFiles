{pkgs, ...}: 
let 
fasterPlugin = import ../plugins/faster.plugin.nix pkgs;
in{
  extraPlugins = with pkgs; [
    # You'll need to install nerdfont symbol font.
    vimPlugins.nvim-web-devicons
    vimPlugins.dropbar-nvim
    (fasterPlugin.package)
  ];

	extraConfigLua = fasterPlugin.luaConfig;
}
